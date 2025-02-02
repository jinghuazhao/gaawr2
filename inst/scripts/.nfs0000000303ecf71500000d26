import plotly.graph_objects as go
import numpy as np

# Observed genotypic counts
observed_counts = {
    "MM": 298,
    "MN": 489,
    "NN": 213
}

# Total number of individuals
total = sum(observed_counts.values())

# Calculate observed genotypic frequencies
observed_frequencies = {
    "MM": observed_counts["MM"] / total,
    "MN": observed_counts["MN"] / total,
    "NN": observed_counts["NN"] / total
}

# Calculate allele frequencies (p for M, q for N)
p = (2 * observed_counts["MM"] + observed_counts["MN"]) / (2 * total)
q = 1 - p

# Calculate expected genotypic frequencies under HWE
expected_frequencies = {
    "MM": p**2,
    "MN": 2 * p * q,
    "NN": q**2
}

# Generate points for the HWE line
hwe_line_points = []
for p_val in np.linspace(0, 1, 100):  # 100 points along the HWE line
    q_val = 1 - p_val
    hwe_line_points.append({
        "MM": p_val**2,
        "MN": 2 * p_val * q_val,
        "NN": q_val**2
    })

# Extract coordinates for the HWE line
hwe_mm = [point["MM"] for point in hwe_line_points]
hwe_mn = [point["MN"] for point in hwe_line_points]
hwe_nn = [point["NN"] for point in hwe_line_points]

# Create the ternary plot
fig = go.Figure(go.Scatterternary(
    a=hwe_mm,  # MM frequencies
    b=hwe_mn,  # MN frequencies
    c=hwe_nn,  # NN frequencies
    mode='lines',
    line=dict(color='blue', width=2),
    name='Hardy-Weinberg Equilibrium Line'
))

# Add the observed point
fig.add_trace(go.Scatterternary(
    a=[observed_frequencies["MM"]],
    b=[observed_frequencies["MN"]],
    c=[observed_frequencies["NN"]],
    mode='markers',
    marker=dict(symbol='circle', size=10, color='red'),
    name='Observed Frequencies'
))

# Customize the layout
fig.update_layout(
    title="Ternary Plot for Hardy-Weinberg Equilibrium Test",
    ternary={
        "sum": 1,
        "aaxis": {"title": "MM Frequency"},
        "baxis": {"title": "MN Frequency"},
        "caxis": {"title": "NN Frequency"}
    }
)

# Show the plot
fig.show()
