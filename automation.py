#!/usr/bin/env python3

import os
import sys
from pathlib import Path
from docx import Document
from fpdf import FPDF

class DocToPDFConverter:
    """A class to convert .docx files to .pdf format."""

    def __init__(self, input_file: str, output_file: str):
        """
        Initializes the converter with input and output file paths.

        Args:
            input_file (str): The path to the input .docx file.
            output_file (str): The path to the output .pdf file.
        """
        self.input_file = Path(input_file)
        self.output_file = Path(output_file)

    def convert(self) -> None:
        """Converts the .docx file to .pdf format."""
        try:
            self._validate_files()
            self._convert_to_pdf()
            print(f"Successfully converted '{self.input_file}' to '{self.output_file}'")
        except Exception as e:
            print(f"Error during conversion: {e}")
            sys.exit(1)

    def _validate_files(self) -> None:
        """Validates the input and output file paths."""
        if not self.input_file.is_file():
            raise FileNotFoundError(f"The input file '{self.input_file}' does not exist.")
        if self.input_file.suffix.lower() != '.docx':
            raise ValueError("Input file must be a .docx file.")
        if self.output_file.suffix.lower() != '.pdf':
            raise ValueError("Output file must have a .pdf extension.")

    def _convert_to_pdf(self) -> None:
        """Converts the .docx file to .pdf using FPDF."""
        document = Document(self.input_file)
        pdf = FPDF()
        pdf.set_auto_page_break(auto=True, margin=15)
        pdf.add_page()
        pdf.set_font("Arial", size=12)

        for para in document.paragraphs:
            pdf.multi_cell(0, 10, para.text)

        pdf.output(self.output_file)

if __name__ == "__main__":
    # Usage: python doc_to_pdf.py <input_file.docx> <output_file.pdf>
    if len(sys.argv) != 3:
        print("Usage: python doc_to_pdf.py <input_file.docx> <output_file.pdf>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]

    converter = DocToPDFConverter(input_file_path, output_file_path)
    converter.convert()