import plotly.graph_objects as go
import numpy as np

def hwe_ternary_plot(observed_counts, hom1_label="A1A1", het_label="A1A2", hom2_label="A2A2"):
    """
    Generates a ternary plot visualizing Hardy-Weinberg Equilibrium (HWE) and observed genotype frequencies
    with customizable genotype labels.

    Args:
        observed_counts (dict): A dictionary with observed counts for genotypes. Keys should match the genotype labels provided.
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
    counts = {genotype_labels["hom1"]: observed_counts.get(genotype_labels["hom1"], 0),
              genotype_labels["het"]: observed_counts.get(genotype_labels["het"], 0),
              genotype_labels["hom2"]: observed_counts.get(genotype_labels["hom2"], 0)}

    total = sum(counts.values())
    observed_frequencies = {label: counts[label] / total if total > 0 else 0 for label in genotype_labels.values()}

    # Calculate allele frequencies (p for allele 1, q for allele 2)
    p = (2 * counts[genotype_labels["hom1"]] + counts[genotype_labels["het"]]) / (2 * total) if total > 0 else 0
    q = 1 - p

    expected_frequencies = {
        genotype_labels["hom1"]: p**2,
        genotype_labels["het"]: 2 * p * q,
        genotype_labels["hom2"]: q**2
    }

    # Generate 100 points for the HWE line
    hwe_line_points = [{"hom1": p_val**2, "het": 2 * p_val * (1 - p_val), "hom2": (1 - p_val)**2} for p_val in np.linspace(0, 1, 100)]

    # a-axis: het (top vertex), b-axis: hom1 (left vertex), c-axis: hom2 (right vertex)
    hwe_het = [point["het"] for point in hwe_line_points]
    hwe_hom1 = [point["hom1"] for point in hwe_line_points]
    hwe_hom2 = [point["hom2"] for point in hwe_line_points]

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

# Example observed counts
observed_counts_list = [
    {"AA": 298, "AB": 489, "BB": 213},
    {"AA": 310, "AB": 470, "BB": 220},
    {"G1G1": 280, "G1G2": 500, "G2G2": 220},
    {"AA": 500, "AB": 100, "BB": 400},
    {"AA": 250, "AB": 500, "BB": 250},
    {"AA": 100, "AB": 800, "BB": 100}
]
labels_list = [
    ("AA", "AB", "BB"),
    ("AA", "AB", "BB"),
    ("G1G1", "G1G2", "G2G2"),
    ("AA", "AB", "BB"),
    ("AA", "AB", "BB"),
    ("AA", "AB", "BB")
]
filenames = [
    "hwe_ternary_plot_original.svg",
    "hwe_ternary_plot_AA_AB_BB.svg",
    "hwe_ternary_plot_G1G1_G1G2_G2G2.svg",
    "hwe_ternary_plot_test_imbalance.svg",
    "hwe_ternary_plot_test_hwe.svg",
    "hwe_ternary_plot_test_far_hwe.svg"
]

for observed_counts, labels, filename in zip(observed_counts_list, labels_list, filenames):
    fig = hwe_ternary_plot(observed_counts, hom1_label=labels[0], het_label=labels[1], hom2_label=labels[2])
    fig.show()
    fig.write_image(filename)
