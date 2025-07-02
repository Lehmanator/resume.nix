#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { convert } from './convert.js';

const inputFile = process.argv[2];
const outputFile = process.argv[3];

// TODO: Handle stdin
if (!inputFile) {
  console.error('Please provide the path to the JSON resume file.');
  process.exit(1);
}
const inputPath = path.resolve(inputFile);

// TODO: Handle stdout
// TODO: Base output path basename on inputPath
let outputPath = path.resolve(process.cwd(), 'rendercv.yaml');
if (outputFile) {
  outputPath = path.resolve(outputFile);
}

fs.readFile(inputPath, 'utf8', async (err, data) => {
  if (err) {
    console.error('Error reading input file:', err);
    process.exit(1);
  }

  let resumeData;
  try {
    resumeData = JSON.parse(data);
  } catch (parseErr) {
    console.error('Error parsing JSON:', parseErr);
    process.exit(1);
  }
  console.log('JSON Resume data read from:', inputPath);

  const rendercvData = await convert(resumeData);

  fs.writeFile(outputPath, rendercvData, (writeErr) => {
    if (writeErr) {
      console.error('Error writing output file:', writeErr);
      process.exit(1);
    }
    console.log('RenderCV data saved to:', outputPath);
  });
});
