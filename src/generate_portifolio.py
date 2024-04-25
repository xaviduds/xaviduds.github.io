import os
import csv
import subprocess


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

def process_directory(dir_path):
    # Initialize the content for 00_generated.html
    generated_html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Generated Portfolio</title>
        <link rel="stylesheet" type="text/css" href="../../../style/style.css">
    </head>
    <body>
    <div class="center60percent">
    <a href="../../../index.html">Home</a> | <a href="../../about.html">About</a> | <a href="../../mainDish.html">AI & ML</a> | <a href="../../nixos.html">NixOS</a>
    <br>
    <br>
    """

    # Get all files in the directory, excluding subdirectories
    files = [f for f in os.listdir(dir_path) if os.path.isfile(os.path.join(dir_path, f))]
    # Sort files alphabetically
    files.sort()

    # for file in files:
    #     file_path = os.path.join(dir_path, file)
    #     if file.endswith('.py'):
    #         subprocess.run(['python', file_path])

    for file in files:
        # Skip the generated.html file itself
        if file == '00_generated.html':
            continue

        # Generate the path to the file
        file_path = os.path.join(dir_path, file)

        # Determine the file type and generate the appropriate HTML content
        if file.endswith('.md'):
            with open(file_path, 'r') as md_file:
                markdown_content = md_file.read()
            generated_html_content += f'<div>{markdown_content}</div>\n'
        elif file.endswith('.csv'):
            csv_content = csv_to_html_table(file_path)
            generated_html_content += f'{csv_content}\n'
        elif file.endswith('.html'):
            # Assuming the file is an HTML snippet that can be directly included
            with open(file_path, 'r') as html_file:
                html_snippet = html_file.read()
            generated_html_content += f'{html_snippet}\n'
        elif file.endswith(('.jpg', '.jpeg', '.png', '.gif')):
            generated_html_content += f'<img src="{file}" alt="Image">\n'
        elif file.endswith('.py'):                
            with open(file_path, 'r') as py_file:
                py_content = py_file.read()
            # Add the toggleable content for the Python file using <details> and <summary>
            generated_html_content += f'<details> <summary>Python Script Used</summary> <pre>{py_content}</pre> </details>\n'
        elif file.endswith(('.mp4', '.webm', '.ogg')):
            generated_html_content += f'<video src="{path}" controls></video>\n'
        elif file.endswith(('.mp3', '.wav')):
            generated_html_content += f'<audio src="{path}" controls></audio>\n'
        else:
            # For other file types, provide a download link
            generated_html_content += f'<a href="{file_path}">Download {file}</a>\n'
        
        generated_html_content += '<br>\n'
        
    generated_html_content += '</div>\n</body>\n</html>'

    # Write the generated content to 00_generated.html
    generated_html_path = os.path.join(dir_path, '00_generated.html')
    with open(generated_html_path, 'w') as generated_html_file:
        generated_html_file.write(generated_html_content)


def create_main_dish_html(data_portifolio_path):
    main_dish_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>AI & ML</title>
        <link rel="stylesheet" type="text/css" href="../style/style.css">
    </head>
    <body>
    <div class="center60percent">
    <a href="../index.html">Home</a> | <a href="about.html">About</a> | <a href="nixos.html">NixOS</a>
    <br>
    <br>
    """

    for root, dirs, files in os.walk(data_portifolio_path):
        if root == data_portifolio_path:
            for dir in dirs:
                dir_path = os.path.join(root, dir)
                anchor_description_path = os.path.join(dir_path, 'anchorDescription/anchorDescription.md')
                if os.path.exists(anchor_description_path):
                    with open(anchor_description_path, 'r') as md_file:
                        anchor_description = md_file.read()
                    main_dish_content += f'<a href="dataPortifolio/{dir}/00_generated.html"><h3>{dir}</h3></a>\n<div>{anchor_description}</div>\n'

    main_dish_content += '</div>\n</body>\n</html>'

    main_dish_path = os.path.join('src', 'mainDish.html')
    with open(main_dish_path, 'w') as main_dish_file:
        main_dish_file.write(main_dish_content)


def main():
    data_portifolio_path = 'src/dataPortifolio/'

    # Process each directory inside dataPortifolio
    for root, dirs, files in os.walk(data_portifolio_path):
        # Adjust the filtering logic to correctly process directories right below dataPortifolio
        if root == data_portifolio_path:
            for dir in dirs:
                dir_path = os.path.join(root, dir)
                process_directory(dir_path)
        else:
            # Skip processing for subdirectories
            dirs[:] = []

    create_main_dish_html(data_portifolio_path)

    
if __name__ == "__main__":
    main()
