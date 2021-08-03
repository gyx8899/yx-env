const archiver = require("archiver");
const fs = require("fs");
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
