const yargs = require("yargs");
const { website, actionType, actionFile, headless } = yargs.argv;

// http://puppeteerjs.com/ puppeteer.js中文网
const puppeteer = require("puppeteer");

(async () => {
    const lanchOptions = {
        // args: ["--no-sandbox", "--disable-setuid-sandbox"],
    };
    if (headless) {
        lanchOptions.headless = !(headless === "false"); // default is true
    }

    const browser = await puppeteer.launch(lanchOptions);
    const page = await browser.newPage();
    // before goto
    switch (actionType) {
        case "screenshot":
            break;
        case "pdf":
            // default - laptop 1366x768
            await page.setViewport({ width: 1366, height: 768 });
            break;
        case "dimensions":
            break;
        default:
        //
    }
    // goto
    await page.goto(website, {
        waitUntil: "networkidle2",
        // waitUntil: "domcontentloaded",
    });
    // after goto
    switch (actionType) {
        case "screenshot":
            await page.screenshot({
                path: `./assets/download/${actionFile}.png`,
            });
            break;
        case "pdf":
            await page.pdf({
                path: `./assets/download/${actionFile}.pdf`,
                format: "a4",
            });
            break;
        case "dimensions":
            const dimensions = await page.evaluate(() => {
                return {
                    width: document.documentElement.clientWidth,
                    height: document.documentElement.clientHeight,
                    deviceScaleFactor: window.devicePixelRatio,
                };
            });
            console.log("Dimensions:", dimenisions);
            break;
        default:
        //
    }

    await browser.close();
})();
