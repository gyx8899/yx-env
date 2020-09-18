import fs from 'fs';

// console.log(fs.readFileSync('../blog/README.md').toString());

function writeDataToFile(fileDirName, data) {
  fs.writeFile(fileDirName, data, (err) => {
    // eslint-disable-next-line no-console
    console.log(`${fileDirName}: ${err ? 'Write File failed!' : 'Saved successfully!'}`);
  });
}

writeDataToFile('./assets/data/test.json', JSON.stringify({a: '1234', b: 234}, null, 4));
