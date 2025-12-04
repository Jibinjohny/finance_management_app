#!/usr/bin/env python3
"""
Convert Word documents to PDF
"""

import subprocess
import sys
import os

def install_package(package):
    """Install a Python package"""
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    from docx2pdf import convert
except ImportError:
    print("Installing docx2pdf...")
    install_package("docx2pdf")
    from docx2pdf import convert

def convert_docx_to_pdf(docx_file, pdf_file):
    """Convert DOCX to PDF"""
    print(f"Converting {docx_file} to {pdf_file}...")
    try:
        convert(docx_file, pdf_file)
        print(f"✅ Successfully created {pdf_file}")
        
        # Get file size
        size = os.path.getsize(pdf_file)
        print(f"   File size: {size / 1024:.1f} KB")
        return True
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    conversions = [
        ("PROJECT_DOCUMENTATION.docx", "PROJECT_DOCUMENTATION.pdf"),
        ("USER_MANUAL.docx", "USER_MANUAL.pdf")
    ]
    
    success_count = 0
    
    for docx_file, pdf_file in conversions:
        docx_path = os.path.join(script_dir, docx_file)
        pdf_path = os.path.join(script_dir, pdf_file)
        
        if not os.path.exists(docx_path):
            print(f"⚠️  {docx_file} not found, skipping...")
            continue
        
        if convert_docx_to_pdf(docx_path, pdf_path):
            success_count += 1
    
    print(f"\n{'='*50}")
    print(f"Conversion complete: {success_count}/{len(conversions)} files")
    print(f"{'='*50}")

if __name__ == "__main__":
    main()
