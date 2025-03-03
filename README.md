## The code in this repository was originally implemented in the analysis of data from experiments characterizing Rli47, a noncoding RNA in Listeria monocytogenes with implications in stress survival

See the upcoming publication for more details

## The RSEM code and differential gene expression RMD files are more broadly applicable to bacterial whole RNAseq

* To map and quantify *cleaned* reads against a reference:
  * Create an index of your reference genome using 1_RSEM_index.sh
  * Multiple RSEM runs can be conducted by running 2_RSEM_controller.sh
    * This in turn runs 3_quantify_RSEM.sh on multiple samples

* RUn DESeq2 on the RSEM count tables generated above using the Rli47 DE Analysis RMD
