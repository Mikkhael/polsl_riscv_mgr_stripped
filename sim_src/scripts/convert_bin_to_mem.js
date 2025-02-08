const fs = require("fs");

const input  = process.argv[2];
const output = process.argv[3];

const data_bin   = fs.readFileSync(input);
const data_words = new Uint32Array(data_bin.buffer,data_bin.byteOffset,data_bin.length/4);

function to_bin_and_pad(val) {
    let str = val.toString(2);
    while(str.length < 32) {
        str = "0" + str;
    }
    // console.log(str, val);
    return str;
}

const res = Array.from(data_words).map(to_bin_and_pad).join('\n');

// console.log(data_words);
// console.log(data_words.map(x => x.toString("X")));
console.log(res);

fs.writeFileSync(output, res);