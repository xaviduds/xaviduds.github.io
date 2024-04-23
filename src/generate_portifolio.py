import os
import csv

def csv_to_html_table(csv_file_path):
    print(f"Processing CSV file: {csv_file_path}")
    with open(csv_file_path, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)
        html_table = "<table>\n"
        for i, row in enumerate(csv_reader):
            if i == 5:
                break
            html_table += "<tr>\n"
            for cell in row:
                html_table += f"<td>{cell}</td>\n"
            html_table += "</tr>\n"
        html_table += "</table>\n"
    return html_table

def process_directory(dir_path):
    print(f"Processing directory: {dir_path}")
    for root, dirs, files in os.walk(dir_path):
        csv_content = ""
        markdown_content = ""
        plotly_html_path = ""

        for file in files:
            if file.endswith('_cp.csv'):
                csv_file_path = os.path.join(root, file)
                csv_content = csv_to_html_table(csv_file_path)
            elif file.endswith('.md'):
                md_file_path = os.path.join(root, file)
                with open(md_file_path, 'r') as md_file:
                    markdown_content = md_file.read()
            elif file.endswith('Plotly.html'):
                plotly_html_path = os.path.join(root, file)

        # Ensure there's content to include in the HTML
        if not csv_content and not markdown_content and not plotly_html_path:
            print(f"No content found in {root}, skipping HTML generation.")
            continue

        html_content = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Generated HTML</title>
            <style>
                table {{
                    border-collapse: collapse;
                    width: 100%;
                }}
                th, td {{
                    border: 1px solid #ddd;
                    padding: 8px;
                }}
                tr:nth-child(even) {{
                    background-color: #f2f2f2;
                }}
            </style>
        </head>
        <body>
            {csv_content}
            <div>{markdown_content}</div>
            {f'<iframe src="{plotly_html_path}" width="100%" height="500"></iframe>' if plotly_html_path else ''}
        </body>
        </html>
        """

        html_file_path = os.path.join(root, 'generated.html')
        print(f"Writing HTML file: {html_file_path}")
        with open(html_file_path, 'w') as html_file:
            html_file.write(html_content)

        for subdir in dirs:
            subdir_path = os.path.join(root, subdir)
            process_directory(subdir_path)

def main():
    process_directory('src/dataPortifolio/')

if __name__ == "__main__":
    main()
