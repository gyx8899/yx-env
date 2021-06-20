function getNodeArgs() {
    const args = {};
    process.argv.slice(2, process.argv.length).forEach((arg) => {
        // long arg
        if (arg.slice(0, 2) === "--") {
            const longArg = arg.split("=");
            const longArgFlag = longArg[0].slice(2, longArg[0].length);
            args[longArgFlag] = longArg.length > 1 ? longArg[1] : true;
            // eslint-disable-next-line brace-style
        } else if (arg[0] === "-") {
            const flags = arg.slice(1, arg.length).split("");
            flags.forEach((flag) => {
                args[flag] = true;
            });
        }
    });
    return args;
}

const nodeArgs = getNodeArgs();
console.log("args: ", nodeArgs);

// 加载后，后续文件支持加载并执行 es6 语法的 js 文件
require("@babel/register");

// 载入动态加载依赖模块
const loadDir = require("../libs/load-dir");
// 解构参数，file 参数必填，others 为该文件执行方法的参数
const { dir = "./", file, ...others } = nodeArgs;
// 获取载入文件夹的实例
const folder = loadDir(dir);
// 动态 require 支持 es6 语法的文件并执行
if (file) {
    try {
        folder[file](others);
    } catch (err) {
        console.error(err);
    }
} else {
    console.error("请确保参数 file 非空：--file=xxxx");
}
