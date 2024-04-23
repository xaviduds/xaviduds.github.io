import os
import csv

def csv_to_html_table(csv_file_path):
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

def process_directory(dir_path, src_path):
    for root, dirs, files in os.walk(dir_path):
        csv_content = ""
        markdown_content = ""
        plotly_html_path = ""
        anchor_description = ""

        for file in files:
            if file.endswith('_cp.csv'):
                csv_file_path = os.path.join(root, file)
                csv_content = csv_to_html_table(csv_file_path)
            elif file.endswith('.md') and file != 'anchorDescription.md':
                md_file_path = os.path.join(root, file)
                with open(md_file_path, 'r') as md_file:
                    markdown_content = md_file.read()
            elif file.endswith('Plotly.html'):
                plotly_html_path = os.path.join(root, file)
            elif file == 'anchorDescription.md':
                anchor_description_path = os.path.join(root, file)
                with open(anchor_description_path, 'r') as anchor_description_file:
                    anchor_description = anchor_description_file.read()

        if csv_content or markdown_content or plotly_html_path:
            # Include a link to style.css in the head section
            css_link = '<link rel="stylesheet" type="text/css" href="../../../style/style.css">'
            html_content = f"""
            <!DOCTYPE html>
            <html>
            <head>
                <title>Generated HTML</title>
                {css_link}
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
            <div class="center60percent">
            <a href="../../../index.html">Home</a> | <a href="../../mainDish.html">AI & ML</a>
            <br>
            <br>
            
                {csv_content}
                <br>
                
                <div>{markdown_content}</div>
                <br>
                
                {f'<iframe src="{plotly_html_path}" width="100%" height="500"></iframe>' if plotly_html_path else ''}
            </div>
            </body>
            </html>
            """

            html_file_path = os.path.join(root, 'generated.html')
            with open(html_file_path, 'w') as html_file:
                html_file.write(html_content)

            # Create or update mainDish.html in src/
            main_dish_path = os.path.join(src_path, 'mainDish.html')
            dir_name = os.path.basename(root)
            anchor_link = f'<a href="{os.path.relpath(html_file_path, src_path)}"><h3>{dir_name}</h3></a>'
            
            # Check if the directory name already exists in mainDish.html
            with open(main_dish_path, 'r') as main_dish_file:
                if dir_name not in main_dish_file.read():
                    with open(main_dish_path, 'a') as main_dish_file_append:
                        main_dish_file_append.write(anchor_link)
                        # Append the anchor description
                        main_dish_file_append.write(f'<p>{anchor_description}</p>')

        for subdir in dirs:
            subdir_path = os.path.join(root, subdir)
            process_directory(subdir_path, src_path)

def main():
    src_path = 'src/'
    data_portifolio_path = 'src/dataPortifolio/'
    # Ensure mainDish.html is empty before processing
    with open(os.path.join(src_path, 'mainDish.html'), 'w') as main_dish_file:
        main_dish_file.write('')
    process_directory(data_portifolio_path, src_path)

if __name__ == "__main__":
    main()
