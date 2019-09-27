The code contains 9 .m files:

1. gaussiansimilarity: calculate Gaussian similarity for miRNA and disease.

2.integratedsimilarity: calculate the final similarity matrix by integrating the information.

3. normFun: laplacian normalization for microbe similarity and disease similarity.

4. thrrw:  unbalanced random walk on the three-layer heterogeneous network.

5. Extract sequence information: Extract sequence features for lncRNA.

6. CosineSmilarity: calculate cosine similarity for lncRNA.

7. bNetrw: random walk on the networks.

8. transition_matrix_network_propagation1: the generated similarity matrix is regularized by Laplace regularization.

9. main: three-layer heterogeneous network combined with unbalanced random walk to calculate association scores for each miRNA-disease pair. 

10.model_evaluate: it is used for evaluation.


1)1.miRNA-disease association， 2.disease semantic similarity 1，3.disease semantic similarity 2，4.miRNA functional simialrity are extracted from Chen, X., Wang, L., Qu, J., Guan, N., and Li, J. (2018). Predicting miRNA–disease association based on inductive matrix completion. Bioinformatics 34, 4256-4265. doi.
2)model_evaluate.m are extracted from Zhang, W., Qu, Q., Zhang, Y., and Wang, W. (2018). The linear neighborhood propagation method for predicting long non-coding RNA–protein interactions. Neurocomputing 273, 526-534. doi: 10.1016/j.neucom.2017.07.065.
3)gaussiansimilarity.m and integratedsimilarity.m are extracted from Chen, X., Wang, L., Qu, J., Guan, N., and Li, J. (2018). Predicting miRNA–disease association based on inductive matrix completion. Bioinformatics 34, 4256-4265. doi.




