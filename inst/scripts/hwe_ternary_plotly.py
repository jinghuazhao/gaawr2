import plotly.graph_objects as go
import numpy as np

def hwe_ternary_plot(observed_counts, hom1_label="A1A1", het_label="A1A2", hom2_label="A2A2"):
    """
    Generates a ternary plot visualizing Hardy-Weinberg Equilibrium (HWE)
    and observed genotype frequencies with customizable genotype labels.

    Args:
        observed_counts (dict): A dictionary with observed counts for genotypes.
                                 Keys should match the genotype labels provided.
                                 e.g., {"AA": 298, "AB": 489, "BB": 213}
        hom1_label (str, optional): Label for the first hom genotype. Defaults to "A1A2".
        het_label (str, optional): Label for the het genotype. Defaults to "A1A2".
        hom2_label (str, optional): Label for the second hom genotype. Defaults to "A2A2".

    Returns:
        plotly.graph_objects.Figure: A Plotly Figure object displaying the ternary plot.
    """

    genotype_labels = {
        "hom1": hom1_label,
        "het": het_label,
        "hom2": hom2_label
    }

    # Extract counts using the provided labels
    # Use .get with default 0 to handle missing keys gracefully
    counts = {
        genotype_labels["hom1"]: observed_counts.get(genotype_labels["hom1"], 0),
        genotype_labels["het"]: observed_counts.get(genotype_labels["het"], 0),
        genotype_labels["hom2"]: observed_counts.get(genotype_labels["hom2"], 0)
    }

    total = sum(counts.values())
    observed_frequencies = {}
    for label in genotype_labels.values():
        observed_frequencies[label] = counts[label] / total if total > 0 else 0 # Avoid division by zero

    # Calculate allele frequencies (p for allele 1, q for allele 2)
    p = (2 * counts[genotype_labels["hom1"]] + counts[genotype_labels["het"]]) / (2 * total) if total > 0 else 0
    q = 1 - p

    expected_frequencies = {
        genotype_labels["hom1"]: p**2,
        genotype_labels["het"]: 2 * p * q,
        genotype_labels["hom2"]: q**2
    }

    # Generate 100 points for the HWE line
    hwe_line_points = []
    for p_val in np.linspace(0, 1, 100):
        q_val = 1 - p_val
        hwe_line_points.append({
            genotype_labels["hom1"]: p_val**2,
            genotype_labels["het"]: 2 * p_val * q_val,
            genotype_labels["hom2"]: q_val**2
        })

    # a-axis: het (top vertex), b-axis: hom1 (left vertex), c-axis: hom2 (right vertex)
    hwe_het = [point[genotype_labels["het"]] for point in hwe_line_points]
    hwe_hom1 = [point[genotype_labels["hom1"]] for point in hwe_line_points]
    hwe_hom2 = [point[genotype_labels["hom2"]] for point in hwe_line_points]

    # Create the ternary plot
    fig = go.Figure(go.Scatterternary(
        a=hwe_het,  # het frequencies for top vertex (a)
        b=hwe_hom1,  # hom1 frequencies for left vertex (b)
        c=hwe_hom2,  # hom2 frequencies for right vertex (c)
        mode='lines',
        line=dict(color='blue', width=2),
        name='Hardy-Weinberg Equilibrium Line'
    ))

    fig.add_trace(go.Scatterternary(
        a=[observed_frequencies[genotype_labels["het"]]],
        b=[observed_frequencies[genotype_labels["hom1"]]],
        c=[observed_frequencies[genotype_labels["hom2"]]],
        mode='markers',
        marker=dict(symbol='circle', size=10, color='red'),
        name='Observed Frequencies'
    ))

    fig.update_layout(
        title="Ternary Plot for Hardy-Weinberg Equilibrium Test",
        ternary={
            "sum": 1,
            "aaxis": {"title": f"{het_label} Frequency"},
            "baxis": {"title": f"{hom1_label} Frequency"},
            "caxis": {"title": f"{hom2_label} Frequency"}
        }
    )

    return fig

# MM, MN, NN labels (original)
observed_counts_original = {"MM": 298, "MN": 489, "NN": 213}
fig_original = hwe_ternary_plot(observed_counts_original)
fig_original.show()

# AA, AB, BB labels
observed_counts_AA_AB_BB = {"AA": 310, "AB": 470, "BB": 220}
fig_AA_AB_BB = hwe_ternary_plot(observed_counts_AA_AB_BB, hom1_label="AA", het_label="AB", hom2_label="BB")
fig_AA_AB_BB.show()

# G1G1, G1G2, G2G2 labels
observed_counts_G1G1_G1G2_G2G2 = {"G1G1": 280, "G1G2": 500, "G2G2": 220}
fig_G1G1_G1G2_G2G2 = hwe_ternary_plot(observed_counts_G1G1_G1G2_G2G2, hom1_label="G1G1", het_label="G1G2", hom2_label="G2G2")
fig_G1G1_G1G2_G2G2.show()

# Imbalance in HWE
observed_counts_test_imbalance = {"AA": 500, "AB": 100, "BB": 400}
fig_test_imbalance = hwe_ternary_plot(observed_counts_test_imbalance, hom1_label="AA", het_label="AB", hom2_label="BB")
fig_test_imbalance.show()

# Roughly in HWE
observed_counts_test_hwe = {"AA": 250, "AB": 500, "BB": 250}
fig_test_hwe = hwe_ternary_plot(observed_counts_test_hwe, hom1_label="AA", het_label="AB", hom2_label="BB")
fig_test_hwe.show()

# Far from HWE
observed_counts_test_far_hwe = {"AA": 100, "AB": 800, "BB": 100}
fig_test_far_hwe = hwe_ternary_plot(observed_counts_test_far_hwe, hom1_label="AA", het_label="AB", hom2_label="BB")
fig_test_far_hwe.show()
