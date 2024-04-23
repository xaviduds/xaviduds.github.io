import plotly.graph_objects as go
import numpy as np

# Create a range of x values from 0 to 10
x = np.linspace(0, 10, 100)

# Create a range of y values as a sine wave
y = np.sin(x)

# Create a trace for the line chart
trace = go.Scatter(x=x, y=y, mode='lines', name='sin(x)')

# Create a layout for the plot
layout = go.Layout(title='Sine Wave Plot',
                   xaxis=dict(title='x'),
                   yaxis=dict(title='sin(x)'))

# Create a figure and add the trace
fig = go.Figure(data=[trace], layout=layout)

# Export the figure as an HTML file
fig.write_html('src/dataPortifolio/regression_0/50_sineWavePlotly.html')
