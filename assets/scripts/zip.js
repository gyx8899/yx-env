const fs = require("fs");

// 压缩文件(夹)
// #1 使用 node 组件
// Dev dependency
const archiver = require("archiver");
const yargs = require("yargs");

const { sourceDir, outFile, hasRoot } = yargs.argv;

zipDirectory(sourceDir, outFile, hasRoot);

function zipDirectory(source, out) {
    // https://www.npmjs.com/package/archiver
    const archive = archiver("zip", { zlib: { level: 9 } });
    const stream = fs.createWriteStream(out);

    return new Promise((resolve, reject) => {
        // /** if false is passed for directory destpath, the path of a chunk of data in the archive is set to the root */
        archive
            .directory(source, hasRoot === "true")
            .on("error", (err) => reject(err))
            .pipe(stream);

        stream.on("close", () => resolve());
        archive.finalize();
    });
}

// #2 使用 shell 执行电脑上的压缩软件，如 7-zip
// "C:\Program Files\7-Zip\7z.exe" a outFile sourceDir
// "C:\Program Files\7-Zip\7z.exe" a ../dist.zip ../dist
