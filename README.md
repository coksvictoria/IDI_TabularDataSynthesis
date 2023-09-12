# Enhancing Public Research on Citizen Data: An Empirical Investigation of Data Synthesis using Statistics New Zealand's Integrated Data Infrastructure
#### Alex X. Wang, Stefanka S. Chukova, Andrew Sporle, Barry J. Milne, Colin R. Simpson, and Binh P. Nguyen(https://people.wgtn.ac.nz/b.nguyen)∗

## Abstract
The Integrated Data Infrastructure (IDI) in New Zealand is a critical asset that integrates citizen data from various public and private organizations for population-level analyses. However, access restrictions within the IDI environment present challenges for fully utilizing its potential. This study examines synthetic data as a potential solution, offering a comprehensive framework for generating customizable and easily implementable synthetic data. The evaluation of multiple data synthesis algorithms considers statistical similarity, machine learning utility, and privacy concerns. The findings reveal that distance-based algorithms, like SMOTE, strike a balance between accuracy and computational cost, making them suitable for IDI. The study also identifies the need for a clear release guide for micro-level synthetic data and proposes exploring a fully automatic data evaluation pipeline in future research. Additionally, the study highlights opportunities enabled by synthetic data, such as familiarization with administrative datasets, reproducibility of studies, pilot analyses, and enhanced cross-domain collaboration. Overall, the proposed framework and findings offer valuable insights and guidance for synthetic data projects within the IDI, advancing synthetic data privacy research and facilitating reproducibility, collaboration, and data sharing in the IDI ecosystem.


## Unified data synthesis pipeline
An overview of the tabular data synthesis pipeline based on real data can be summarised in six steps:

1. **problem formulation** formulate the whole pipeline based on business question.
2. **schema detection** an understanding of the structure and organization of the data being synthesized, including the relationships and dependencies between the different attributes and features.
3. **feature selection**  A robust feature selection process can help reduce the dimensionality of the data, remove irrelevant or redundant features, and ensure that the resulting synthetic data accurately reflects the underlying relationships and patterns in the original data.
4. **data generation** one or various data synthesis models can be applied.
5. **data evaluation** the data evaluation metrics need to be selected based on the downstream tasks.
6. **post-generation transformation**  Instead of a linear, one-time evaluation, these two steps form a cyclical flow. In each cycle, the process entails evaluating the synthetic data from multiple perspectives, including data utility and privacy, compared to real data.



## Results

In conclusion, our findings provide valuable insights and guidance for future synthetic data endeavors within IDI. Synthetic data holds the potential to elevate and advance public research on citizen data through multiple channels, such as expanded research accessibility, reproducibility of previous studies, increased collaboration, and enhanced data shareability. Therefore, we believe these benefits make synthetic data an important area at IDI for continued exploration and development. While our primary focus is on the application of synthetic data within IDI, we acknowledge the importance of considering broader implications. IDI represents a national strategic asset in New Zealand, and analogous data infrastructures exist in other nations. Therefore, we believe our study offers insights that transcend specific datasets or regions, making a meaningful contribution to the wider field of data synthesis and its versatile applications.

## Availability and implementation
Source code and data are available at [GitHub](https://github.com/coksvictoria/IDI_TabularDataSynthesis/)

## Contact 
[Go to contact information](https://homepages.ecs.vuw.ac.nz/~nguyenb5/contact.html)

