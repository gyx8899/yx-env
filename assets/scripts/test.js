import fs from 'fs';

// console.log(fs.readFileSync('../blog/README.md').toString());

function writeDataToFile(fileDirName, data) {
  fs.writeFile(fileDirName, data, (err) => {
    // eslint-disable-next-line no-console
    console.log(`${fileDirName}: ${err ? 'Write File failed!' : 'Saved successfully!'}`);
  });
}

function main(args) {
  console.log(args);
  writeDataToFile('./assets/data/test.json', JSON.stringify({a: args[0], b: args[1]},null, 4));
}

// export default main;
module.exports = main;
