# SNA-project
## Prerequisites
Ensure you have Python 3.x installed and have created a virtual environment. You can install the required dependencies through the `requirements.txt` file.
```
pip3 install -r requirements.txt
```

## Usage
_Optional:_  Run the scraper to download the dataset:
```
python scraper.py
```
Run the main script to visualize the entire graph:
```
python main.py
```
To filter the data by the author's name when running the program, you can specify the author's name as a command-line argument. For example:
```
python main.py "Giallorenzo, Saverio"
```

You can refer to the Jupyter Notebook ```metrics.ipynb``` for the metrics used in the analysis.

Il progetto consiste nell'analisi di una rete; in questo caso specifico si tratta delle pubblicazioni del dipartimento disi dell'università di Bologna.