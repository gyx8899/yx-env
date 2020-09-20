const cgf = require("changed-git-files");
const {readDataFromFile, writeDataToFile, iterateObject} = require('@daybyday/yx-node');

const readmeFilePath = './README.md';
const summaryFilePath = './SUMMARY.md';
const ignoredMdFilesInTree = ['README.md', 'SUMMARY.md', 'GLOSSORY.md'];
const ignoredFolderInTree = ['_book', 'node_modules', '.next', '.git'];

function generateReadme(_mdConfig, _readMeConfig) {
	let content = '';
	const nonLeaf = function (key, level, value) {
		if (value.date) {
			leaf(key, value);
		} else if (_readMeConfig[key]) {
			const _config = _readMeConfig[key],
					isConfigStr = typeof _config === 'string',
					title = isConfigStr ? _config : _config.title;
			content += `\n${Array(level).fill('#').join('')} ${key.substring(0, 1).toUpperCase() + key.substring(1)}\n${title || ''}\n\n`;
			if (!isConfigStr) {
				if (_config.desc) {
					content += `*${_config.desc}*\n`;
				}
				if (_config.list && _config.list.length) {
					_config.list.forEach((item) => {
						content += `\n> ${item}\n> `;
					});
					content += '\n'
				}
			}
		}

	};
	const leaf = function (key, value) {
		if (ignoredMdFilesInTree.indexOf(key) === -1 && value.date) {
			content += `- [${value.title || key.split('.md')[0]}](/${encodeURI(value.path)}): <sub><sup>(${value.date})</sup></sub>\n`;
		}
	};
	iterateObject(_mdConfig, 1, nonLeaf, () => {
	});

	writeDataToFile(readmeFilePath, content);
}

function updateReadMeAndSummary(isSummary, project) {
	if (isSummary) {
		let content = `# Summary\n\n[${project}](README.md)\n`;
		const nonLeaf = function (key, level, value) {
			if (value.date) {
				leaf(key, value);
			} else if (_readMeConfig[key]) {
				const _config = _readMeConfig[key],
						isConfigStr = typeof _config === 'string',
						title = isConfigStr ? _config : _config.title;
				content += `\n## ${key.substring(0, 1).toUpperCase() + key.substring(1)}\n${title || ''}\n\n`;
			}
		};
		const leaf = function (key, value) {
			if (ignoredMdFilesInTree.indexOf(key) === -1 && value.date) {
				content += `* [${value.title || key.split('.md')[0]}](/${encodeURI(value.path)})\n`;
			}
		};



		writeDataToFile(summaryFilePath, content);
	}
}

function main([project]) {
	cgf(function (err, results) {
		let isReadMeChange = false;
		let isSummaryChange = false;

		results && results.forEach((file) => {
			const {filename, status} = file;

			if (filename.indexOf('.md') !== -1 && ignoredMdFilesInTree.indexOf(filename) === -1) {
				switch (status) {
					case "Added":
					case "Deleted":
					case "Renamed":
						isSummaryChange = true;
						isReadMeChange = true;
						break;
					case "Modified":
					case "Copied":
						isReadMeChange = true;
						break;
					default:
						// Nothing
				}
			}
		});

		if (isReadMeChange) {
			updateReadMeAndSummary(isSummaryChange, project);
		}
	});
}

module.exports = main;
