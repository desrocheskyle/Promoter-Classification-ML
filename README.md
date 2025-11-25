# 🧬 Bioinformatics ML: Promoter Region Classification

A Classification Project showcasing Data Science techniques to identify promoter regions in DNA sequences.
## 🎯 Project Goal
The objective of this project was to develop a high-accuracy Machine Learning model to classify DNA sequences as either **promoter regions** or **non-promoter regions**. Promoter regions are critical sequences near transcription start sites that regulate gene transcription.

### 📈 Final Model Performance
| Model | Metric | Value (e.g., ROC AUC) |
| :--- | :--- | :--- |
| **[Winning Model Name]** | **ROC AUC** | **[Insert Your Best Score]** |
| [Second Best Model] | ROC AUC | [Insert Second Best Score] |

[Link to Full Report](promoterclassification.html)
---

## 🔬 Data Science Methodology

This project followed a rigorous methodology focusing heavily on **Feature Engineering**—the most valuable skill for a Data Science role.

### 1. Feature Engineering (The DS Value-Add)
We engineered features from the raw DNA sequences using Bioinformatics principles, which were crucial for high model performance:

* **Nucleotide Proportions:** Calculated the proportions of Adenine (A), Thymine (T), Cytosine (C), and Guanine (G).
* **CpG Island Creation:** Engineered a binary feature to identify **CpG islands**—clusters of CG dinucleotides—which are highly indicative of promoter regions.
* **Sequence Bendability:** Used a supplementary TSV file of 3-mer scores to calculate the **average bendability** of each sequence, a known predictor of DNA function.

### 2. Model Development & Evaluation
Multiple classification algorithms were explored and tuned using **cross-validation** to identify the most robust model:

| Algorithm Used | Purpose & Rationale |
| :--- | :--- |
| **Random Forest (RF)** | Used for its high predictive power and ability to handle high-dimensional, non-linear data. |
| **Support Vector Machine (SVM)** | Evaluated for performance on complex boundaries, especially with a Radial Basis Function (RBF) kernel. |
| **Regularized Models** | **Lasso/Logistic Regression** and **Regularized Discriminant Analysis (RDA/LDA)** were tested to understand feature impact and prevent overfitting on sparse features. |

### 3. Key Findings (Showcasing Results)
The tuning process, primarily using **ROC AUC** as the performance metric, revealed [Briefly state what your final model or feature engineering showed, e.g., "that Random Forest slightly outperformed SVM, and the CpG island feature was the most important predictor"].

---

## 🛠️ Tech Stack & Dependencies
* **Language:** R
* **Core Packages:** `tidyverse` (for data wrangling and cleaning), `ggplot2` (for EDA visualizations), `tidymodels` (for model building and tuning).
* **Source Data:** [Kaggle - Promoter or Not Bioinformatics Dataset](https://www.kaggle.com/datasets/samira1992/promoter-or-not-bioinformatics-dataset).

---

*Authored by Kyle DesRoches - UCSB Spring 2024*
