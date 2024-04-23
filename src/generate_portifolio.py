import os
import csv

def process_directory(dir_path):
    csv_content = ""
    markdown_content = ""
    plotly_html_path = ""

    for root, dirs, files in os.walk(dir_path):
        for file in files:
            if file.endswith('_cp.csv'):
                with open(os.path.join(root, file), 'r') as csv_file:
                    csv_reader = csv.reader(csv_file)
                    csv_content = "\n".join([", ".join(row) for row in csv_reader])
            elif file.endswith('.md'):
                with open(os.path.join(root, file), 'r') as md_file:
                    markdown_content = md_file.read()
            elif file.endswith('Plotly.html'):
                plotly_html_path = os.path.join(root, file)

    # Generate HTML content
    html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Generated HTML</title>
    </head>
    <body>
        <pre>{csv_content}</pre>
        <div>{markdown_content}</div>
        {f'<iframe src="{plotly_html_path}" width="100%" height="500"></iframe>' if plotly_html_path else ''}
    </body>
    </html>
    """

    # Write to HTML file
    with open(os.path.join(dir_path, 'generated.html'), 'w') as html_file:
        html_file.write(html_content)

    # Process subdirectories
    for subdir in dirs:
        subdir_path = os.path.join(dir_path, subdir)
        process_directory(subdir_path)

def main():
    # Replace 'your_project_directory_path' with the path to the project directory
    process_directory('./src/dataPortifolio')

if __name__ == "__main__":
    main()
