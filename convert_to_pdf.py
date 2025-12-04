#!/usr/bin/env python3
"""
Convert HTML documentation files to PDF using WeasyPrint
"""

from weasyprint import HTML
import os

def convert_html_to_pdf(html_file, pdf_file):
    """Convert HTML file to PDF"""
    print(f"Converting {html_file} to {pdf_file}...")
    try:
        HTML(filename=html_file).write_pdf(pdf_file)
        print(f"✅ Successfully created {pdf_file}")
        return True
    except Exception as e:
        print(f"❌ Error converting {html_file}: {e}")
        return False

def main():
    # Get the directory where the script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Define file pairs (HTML -> PDF)
    conversions = [
        ("PROJECT_DOCUMENTATION.html", "PROJECT_DOCUMENTATION.pdf"),
        ("USER_MANUAL.html", "USER_MANUAL.pdf")
    ]
    
    success_count = 0
    
    for html_file, pdf_file in conversions:
        html_path = os.path.join(script_dir, html_file)
        pdf_path = os.path.join(script_dir, pdf_file)
        
        if not os.path.exists(html_path):
            print(f"⚠️  Warning: {html_file} not found, skipping...")
            continue
        
        if convert_html_to_pdf(html_path, pdf_path):
            success_count += 1
            # Get file size
            size = os.path.getsize(pdf_path)
            size_kb = size / 1024
            print(f"   File size: {size_kb:.1f} KB")
    
    print(f"\n{'='*50}")
    print(f"Conversion complete: {success_count}/{len(conversions)} files converted")
    print(f"{'='*50}")

if __name__ == "__main__":
    main()
