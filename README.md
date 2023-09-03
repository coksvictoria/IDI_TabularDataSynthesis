# IDI_TabularDataSynthesis

## Enhancing Public Research on Citizen Data: An Empirical Investigation of Data Synthesis using Statistics New Zealand's Integrated Data Infrastructure

The Integrated Data Infrastructure (IDI) in New Zealand is a critical asset that integrates citizen data from various public and private organizations for population-level analyses. However, access restrictions within the IDI environment present challenges for fully utilizing its potential. This study examines synthetic data as a potential solution, offering a comprehensive framework for generating customizable and easily implementable synthetic data. The evaluation of multiple data synthesis algorithms considers statistical similarity, machine learning utility, and privacy concerns. The findings reveal that distance-based algorithms, like SMOTE, strike a balance between accuracy and computational cost, making them suitable for IDI. The study also identifies the need for a clear release guide for micro-level synthetic data and proposes exploring a fully automatic data evaluation pipeline in future research. Additionally, the study highlights opportunities enabled by synthetic data, such as familiarization with administrative datasets, reproducibility of studies, pilot analyses, and enhanced cross-domain collaboration. Overall, the proposed framework and findings offer valuable insights and guidance for synthetic data projects within the IDI, advancing synthetic data privacy research and facilitating reproducibility, collaboration, and data sharing in the IDI ecosystem.


An overview of the tabular data synthesis pipeline based on real data can be summarised in six steps:

1. **problem formulation** formulate the whole pipeline based on business question.
2. **schema detection** an understanding of the structure and organization of the data being synthesized, including the relationships and dependencies between the different attributes and features.
3. **feature selection**  A robust feature selection process can help reduce the dimensionality of the data, remove irrelevant or redundant features, and ensure that the resulting synthetic data accurately reflects the underlying relationships and patterns in the original data.
4. **data generation** one or various data synthesis models can be applied.
5. **data evaluation** the data evaluation metrics need to be selected based on the downstream tasks.
6. **post-generation transformation**  Instead of a linear, one-time evaluation, these two steps form a cyclical flow. In each cycle, the process entails evaluating the synthetic data from multiple perspectives, including data utility and privacy, compared to real data.

This synthethic data will then be added to the original training data. The augmented training data will then be used to train a white-box model, for example a shallow decision tree. The resulting performance gain is then used as a proxy for augmentation quality.

This work was done as part of my Bachelor thesis "Benchmarking Tabular Data Synthesis Pipelines for Mixed Data".

## Installation

The required packages can be installed through the 'requirements.txt' file. If you have pip installed you can simply run:

```bash
pip install -r requirements.txt
```
