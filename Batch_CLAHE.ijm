// Macro for batch CLAHE on primary neuronal cultures stained with MAP2.
// Tommaso Bianucci and Elisa Nerli, 2017

  
inputDir = getDirectory("Choose Source Directory ");
outputDir = getDirectory("Choose Destination Directory ");
Dialog.create("Batch CLAHE");
Dialog.addString("Blocksize", "127");
Dialog.addString("Histogram bins", "256");
Dialog.addString("Maximum slope", "3.00");
Dialog.addCheckbox("Fast (suggested)", true);
Dialog.show();

blockSize = Dialog.getString();
histogramBins = Dialog.getString();
maxSlope = Dialog.getString();
fast = Dialog.getCheckbox();

fileList = getFileList(inputDir);
//print(inputDir);
//print(outputDir);
//setBatchMode(true);

numFiles = fileList.length;
for (i=0; i<numFiles; i++)
{
  showProgress(i+1, numFiles); 
  currentFile = fileList[i]; //OCIO! Le liste si inziano a numerare da 0. Le quadre servono ad accedere ad una lista/array, mentre le tonde per una chiamata di funzione
  //print(currentFile);
  open(inputDir + currentFile);
  if (fast) 
  {
  	run("Enhance Local Contrast (CLAHE)", "blocksize="+blockSize+" histogram="+histogramBins+" maximum="+maxSlope+" mask=*None* fast_(less_accurate)");
  }
  else 
  {
  	run("Enhance Local Contrast (CLAHE)", "blocksize="+blockSize+" histogram="+histogramBins+" maximum="+maxSlope+" mask=*None*");
  }
  saveAs("tiff", outputDir+currentFile);
  close();
}



