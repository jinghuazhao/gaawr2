import plotly.graph_objects as go
import numpy as np

def hwe_ternary_plot(observed_counts, hom1_label="A1A1", het_label="A1A2", hom2_label="A2A2"):
    """Generates a ternary plot visualizing Hardy-Weinberg Equilibrium (HWE) and observed genotype frequencies."""
    # Define genotype labels and observed counts
    genotype_labels = {"hom1": hom1_label, "het": het_label, "hom2": hom2_label}
    counts = {genotype_labels["hom1"]: observed_counts.get(genotype_labels["hom1"], 0),
              genotype_labels["het"]: observed_counts.get(genotype_labels["het"], 0),
              genotype_labels["hom2"]: observed_counts.get(genotype_labels["hom2"], 0)}
    total = sum(counts.values())
    observed_frequencies = {label: count / total if total > 0 else 0 for label, count in counts.items()}
    # Calculate allele frequencies and expected frequencies
    p = (2 * counts[genotype_labels["hom1"]] + counts[genotype_labels["het"]]) / (2 * total) if total > 0 else 0
    q = 1 - p
    expected_frequencies = {
        genotype_labels["hom1"]: p**2,
        genotype_labels["het"]: 2 * p * q,
        genotype_labels["hom2"]: q**2
    }
    # Generate HWE line points
    hwe_line_points = [{"hom1": p_val**2, "het": 2 * p_val * (1 - p_val), "hom2": (1 - p_val)**2} for p_val in np.linspace(0, 1, 100)]
    hwe_het = [point["het"] for point in hwe_line_points]
    hwe_hom1 = [point["hom1"] for point in hwe_line_points]
    hwe_hom2 = [point["hom2"] for point in hwe_line_points]
    # Create the ternary plot
    fig = go.Figure(go.Scatterternary(
        a=hwe_het, b=hwe_hom1, c=hwe_hom2,
        mode='lines', line=dict(color='blue', width=2),
        name='Hardy-Weinberg Equilibrium Line'
    ))
    fig.add_trace(go.Scatterternary(
        a=[observed_frequencies[genotype_labels["het"]]],
        b=[observed_frequencies[genotype_labels["hom1"]]],
        c=[observed_frequencies[genotype_labels["hom2"]]],
        mode='markers', marker=dict(symbol='circle', size=10, color='red'),
        name='Observed Frequencies'
    ))
    # Update layout to position legend below the plot and title below the legend
    fig.update_layout(
        title="Ternary plot for Hardy-Weinberg equilibrium test",
        title_x=0.5,
        title_y=0.05,
        title_yanchor='bottom',
        legend=dict(
            orientation='h',
            y=1.25,
            x=0.5,
            xanchor='center',
            yanchor='top'
        ),
        ternary={
            "sum": 1,
            "aaxis": {"title": f"{het_label} Frequency"},
            "baxis": {"title": f"{hom1_label} Frequency"},
            "caxis": {"title": f"{hom2_label} Frequency"}
        }
    )
    return fig
genotype_and_filenames = [
    {"AA": 298, "AB": 489, "BB": 213, "filename": "hwe_ternary_plot_original.svg"},
    {"AA": 310, "AB": 470, "BB": 220, "filename": "hwe_ternary_plot_AA_AB_BB.svg"},
    {"G1G1": 280, "G1G2": 500, "G2G2": 220, "filename": "hwe_ternary_plot_G1G1_G1G2_G2G2.svg"},
    {"AA": 500, "AB": 100, "BB": 400, "filename": "hwe_ternary_plot_test_imbalance.svg"},
    {"AA": 250, "AB": 500, "BB": 250, "filename": "hwe_ternary_plot_test_hwe.svg"},
    {"AA": 100, "AB": 800, "BB": 100, "filename": "hwe_ternary_plot_test_far_hwe.svg"}
]
for data in genotype_and_filenames:
    observed_counts = {key: value for key, value in data.items() if key != 'filename'}
    filename = data['filename']
    labels = list(observed_counts.keys())
    fig = hwe_ternary_plot(observed_counts, hom1_label=labels[0], het_label=labels[1], hom2_label=labels[2])
    fig.show()
    fig.write_image(filename)
