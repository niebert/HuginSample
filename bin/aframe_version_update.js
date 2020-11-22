const w4f = require('walker4folder');

function my_handle_file(file,pathItem,dirAppend) {
  if (file.lastIndexOf(".html") >= file.length - 5) {
    /*
    console.log("File:         '" + file + "'");
    console.log("Path File:    '" + pathItem + "'");
    console.log("Subdirectory: '" + dirAppend + "'");
    */
  }
}

function my_handle_dir(file,pathItem,dirAppend) {
  console.log("Directory:           '" + file + "'");
  console.log("Path Dir:            '" + pathItem + "'");
  console.log("Parent Subdirectory: '" + dirAppend + "'");
}

w4f.walker4folder("./docs",my_handle_file);
// w4f.walker4folder("./docs",my_handle_file,my_handle_dir);
//w4f.walker4folder("./docs",null,my_handle_dir);
