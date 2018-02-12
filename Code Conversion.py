Python 3.6.4 (v3.6.4:d48eceb, Dec 19 2017, 06:04:45) [MSC v.1900 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> import pandas as pd
Traceback (most recent call last):
  File "<pyshell#0>", line 1, in <module>
    import pandas as pd
ModuleNotFoundError: No module named 'pandas'
>>> import pandas as pd
>>> df =pd.read_csv("F:\\SAS\\sample_data_module1.xlsx")
Traceback (most recent call last):
  File "<pyshell#2>", line 1, in <module>
    df =pd.read_csv("F:\\SAS\\sample_data_module1.xlsx")
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\parsers.py", line 709, in parser_f
    return _read(filepath_or_buffer, kwds)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\parsers.py", line 449, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\parsers.py", line 818, in __init__
    self._make_engine(self.engine)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\parsers.py", line 1049, in _make_engine
    self._engine = CParserWrapper(self.f, **self.options)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\parsers.py", line 1695, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "pandas\_libs\parsers.pyx", line 562, in pandas._libs.parsers.TextReader.__cinit__
  File "pandas\_libs\parsers.pyx", line 790, in pandas._libs.parsers.TextReader._get_header
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xc1 in position 0: invalid start byte
>>> df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
Traceback (most recent call last):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\excel.py", line 261, in __init__
    import xlrd
ModuleNotFoundError: No module named 'xlrd'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<pyshell#3>", line 1, in <module>
    df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\util\_decorators.py", line 118, in wrapper
    return func(*args, **kwargs)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\excel.py", line 230, in read_excel
    io = ExcelFile(io, engine=engine)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\io\excel.py", line 263, in __init__
    raise ImportError(err_msg)
ImportError: Install xlrd >= 0.9.0 for Excel support
>>> df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
>>> df
         campaign     medium                       instance_id  \
0             NaN        NaN  000bff55caf956a6255365a5acca48f2   
1             NaN        NaN  000bff55caf956a6255365a5acca48f2   
2             NaN        NaN  000bff55caf956a6255365a5acca48f2   
3             NaN        NaN  000bff55caf956a6255365a5acca48f2   
4             NaN        NaN  000bff55caf956a6255365a5acca48f2   
5             NaN        NaN  000bff55caf956a6255365a5acca48f2   
6             NaN        NaN  000bff55caf956a6255365a5acca48f2   
7             NaN        NaN  000bff55caf956a6255365a5acca48f2   
8             NaN        NaN  000bff55caf956a6255365a5acca48f2   
9             NaN        NaN  000bff55caf956a6255365a5acca48f2   
10            NaN        NaN  000bff55caf956a6255365a5acca48f2   
11            NaN        NaN  000bff55caf956a6255365a5acca48f2   
12            NaN        NaN  000bff55caf956a6255365a5acca48f2   
13            NaN        NaN  000bff55caf956a6255365a5acca48f2   
14            NaN        NaN  000bff55caf956a6255365a5acca48f2   
15            NaN        NaN  000bff55caf956a6255365a5acca48f2   
16            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
17            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
18            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
19            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
20            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
21            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
22            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
23            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
24            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
25            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
26            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
27            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
28            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
29             c3        NaN  001d7324e01e1e8e063fa976c2fabc25   
..            ...        ...                               ...   
72            NaN        NaN  00225f1f30f3584e9600364280825ba6   
73            NaN        NaN  00225f1f30f3584e9600364280825ba6   
74            NaN        NaN  00225f1f30f3584e9600364280825ba6   
75            NaN        NaN  00225f1f30f3584e9600364280825ba6   
76            NaN        NaN  00225f1f30f3584e9600364280825ba6   
77            NaN        NaN  00225f1f30f3584e9600364280825ba6   
78            NaN        NaN  00225f1f30f3584e9600364280825ba6   
79            NaN        NaN  00225f1f30f3584e9600364280825ba6   
80             c3        NaN  00225f1f30f3584e9600364280825ba6   
81            NaN        NaN  00225f1f30f3584e9600364280825ba6   
82            NaN        NaN  00225f1f30f3584e9600364280825ba6   
83            NaN        NaN  00225f1f30f3584e9600364280825ba6   
84            NaN        NaN  00225f1f30f3584e9600364280825ba6   
85            NaN        NaN  00225f1f30f3584e9600364280825ba6   
86   personalinfo  Reminders  00225f1f30f3584e9600364280825ba6   
87            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
88            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
89            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
90            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
91            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
92            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
93            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
94            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
95            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
96            NaN    organic  01096799fcc6780dd275c71e6c6e1571   
97            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
98            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
99            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
100           NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
101           NaN        NaN  01096799fcc6780dd275c71e6c6e1571   

     timestamp_micros  kns__screen_class  \
0    1514091286070000      LoginActivity   
1    1514091266503000                NaN   
2    1514091269153000      LoginActivity   
3    1514091274303000      LoginActivity   
4    1514091274468000                NaN   
5    1514091276243000      LoginActivity   
6    1514091279662000      LoginActivity   
7    1514091538197000                NaN   
8    1514091385909000                NaN   
9    1514091386142000      LoginActivity   
10   1514091391092000                NaN   
11   1514091391246000    WebviewActivity   
12   1514091423590000      LoginActivity   
13   1514091426726000                NaN   
14   1514091426939000    WebviewActivity   
15   1514091431796010      LoginActivity   
16   1513536810071000      LoginActivity   
17   1513574261286000                NaN   
18   1513574261432000      LoginActivity   
19   1513574263997000      LoginActivity   
20   1513574264252000          Dashboard   
21   1513574271127000          Dashboard   
22   1513536837073000      LoginActivity   
23   1513536840212000      LoginActivity   
24   1513536886468000          Dashboard   
25   1513536886633000          Dashboard   
26   1513536952992000          Dashboard   
27   1513536806861000                NaN   
28   1513536807758000      LoginActivity   
29   1513536808260000      LoginActivity   
..                ...                ...   
72   1513538006193000          Dashboard   
73   1513538006614000          Dashboard   
74   1513537965088000      LoginActivity   
75   1513537973598000                NaN   
76   1513537974547000          Dashboard   
77   1513537980410000          Dashboard   
78   1513537948625000                NaN   
79   1513537949393000      LoginActivity   
80   1513537950993000      LoginActivity   
81   1513707637188000                NaN   
82   1513707637331000      LoginActivity   
83   1513707639560000      LoginActivity   
84   1513707639951000          Dashboard   
85   1513707647678000          Dashboard   
86   1513707637123000                NaN   
87   1513670705266000          Dashboard   
88   1513670712841000          Dashboard   
89   1513670731109000          Dashboard   
90   1513670731344000          Dashboard   
91   1513670754016010          Dashboard   
92   1513670761272010                NaN   
93   1513670693846000      LoginActivity   
94   1513670691952000                NaN   
95   1513670692359000      LoginActivity   
96   1513670692808000      LoginActivity   
97   1513670704849000                NaN   
98   1513670693878000                NaN   
99   1513670694015000      LoginActivity   
100  1513670696106000  SignInHubActivity   
101  1513670699924000      LoginActivity   

                                               kns_lid kns__conversion  \
0    EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...               .   
1                                                  NaN               1   
2                                                  NaN               .   
3                                                  NaN               .   
4                                                  NaN               .   
5                                                  NaN               .   
6                                                  NaN               1   
7                                                  NaN               .   
8                                                  NaN               .   
9                                                  NaN               .   
10                                                 NaN               .   
11                                                 NaN               .   
12                                                 NaN               .   
13                                                 NaN               .   
14                                                 NaN               .   
15                                                 NaN               .   
16                                                 NaN               .   
17                                                 NaN               .   
18                                                 NaN               .   
19                                                 NaN               1   
20                                                 NaN               .   
21                                                 NaN               .   
22                                                 NaN               .   
23                                                 NaN               1   
24                                                 NaN               .   
25                                                 NaN               .   
26                                                 NaN               .   
27                                                 NaN               1   
28                                                 NaN               .   
29                                                 NaN               .   
..                                                 ...             ...   
72                                                 NaN               .   
73                                                 NaN               .   
74                                                 NaN               .   
75                                                 NaN               1   
76                                                 NaN               .   
77                                                 NaN               1   
78                                                 NaN               1   
79                                                 NaN               .   
80                                                 NaN               .   
81                                                 NaN               .   
82                                                 NaN               .   
83                                                 NaN               1   
84                                                 NaN               .   
85                                                 NaN               1   
86                                                 NaN               .   
87                                                 NaN               .   
88                                                 NaN               1   
89                                                 NaN               .   
90                                                 NaN               .   
91                                                 NaN               .   
92                                                 NaN               .   
93                                                 NaN               .   
94                                                 NaN               1   
95                                                 NaN               .   
96                                                 NaN               .   
97                                                 NaN               1   
98                                                 NaN               .   
99                                                 NaN               .   
100                                                NaN               .   
101                                                NaN               .   

                name    userId                       _id kns__event_origin  \
0      kns__campaign       NaN  5a6c7ef1fd2cc626d90322ad              auto   
1         first_open       NaN  5a6c7ef1fd2cc626d90322ae              auto   
2        screen_view       NaN  5a6c7ef1fd2cc626d90322ae              auto   
3        SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322af               web   
4        SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322b0               web   
5        screen_view       NaN  5a6c7ef1fd2cc626d90322b0              auto   
6      session_start       NaN  5a6c7ef1fd2cc626d90322b0              auto   
7         web_remove       NaN  5a6c7ef1fd2cc626d90322b1              auto   
8        SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322b2               web   
9        screen_view       NaN  5a6c7ef1fd2cc626d90322b2              auto   
10      HOW_IT_WORKS       NaN  5a6c7ef1fd2cc626d90322b2               web   
11       screen_view       NaN  5a6c7ef1fd2cc626d90322b2              auto   
12       screen_view       NaN  5a6c7ef1fd2cc626d90322b2              auto   
13      HOW_IT_WORKS       NaN  5a6c7ef1fd2cc626d90322b2               web   
14       screen_view       NaN  5a6c7ef1fd2cc626d90322b2              auto   
15       screen_view       NaN  5a6c7ef1fd2cc626d90322b2              auto   
16       SELECT_LANG       NaN  5a6c7e22fd2cc626d9001159               web   
17       SELECT_LANG       NaN  5a6c7e22fd2cc626d900115a               web   
18       screen_view       NaN  5a6c7e22fd2cc626d900115a              auto   
19           SIGN_IN  144741.0  5a6c7e22fd2cc626d900115a               web   
20       screen_view       NaN  5a6c7e22fd2cc626d900115a              auto   
21       screen_view       NaN  5a6c7e22fd2cc626d900115a              auto   
22       screen_view       NaN  5a6c7e22fd2cc626d900115b              auto   
23     session_start       NaN  5a6c7e22fd2cc626d900115b              auto   
24   GETTING_STARTED       NaN  5a6c7e22fd2cc626d900115c               web   
25       screen_view       NaN  5a6c7e22fd2cc626d900115c              auto   
26       screen_view       NaN  5a6c7e22fd2cc626d900115c              auto   
27        first_open       NaN  5a6c7e22fd2cc626d900115d              auto   
28       screen_view       NaN  5a6c7e22fd2cc626d900115d              auto   
29     kns__campaign       NaN  5a6c7e22fd2cc626d900115d              auto   
..               ...       ...                       ...               ...   
72   GETTING_STARTED       NaN  5a6c7e18fd2cc626d9ffe559               web   
73       screen_view       NaN  5a6c7e18fd2cc626d9ffe559              auto   
74       screen_view       NaN  5a6c7e18fd2cc626d9ffe55a              auto   
75           SIGN_IN  144754.0  5a6c7e18fd2cc626d9ffe55a               web   
76       screen_view       NaN  5a6c7e18fd2cc626d9ffe55a              auto   
77     session_start       NaN  5a6c7e18fd2cc626d9ffe55a              auto   
78        first_open       NaN  5a6c7e18fd2cc626d9ffe55c              auto   
79       screen_view       NaN  5a6c7e18fd2cc626d9ffe55c              auto   
80     kns__campaign       NaN  5a6c7e18fd2cc626d9ffe55c              auto   
81       SELECT_LANG       NaN  5a6c7e42fd2cc626d90083e1               web   
82       screen_view       NaN  5a6c7e42fd2cc626d90083e1              auto   
83           SIGN_IN  144754.0  5a6c7e42fd2cc626d90083e1               web   
84       screen_view       NaN  5a6c7e42fd2cc626d90083e1              auto   
85     session_start       NaN  5a6c7e42fd2cc626d90083e1              auto   
86     kns__campaign       NaN  5a6c7e42fd2cc626d90083e2              auto   
87       screen_view       NaN  5a6c7e44fd2cc626d9008b5f              auto   
88     session_start       NaN  5a6c7e44fd2cc626d9008b5f              auto   
89   GETTING_STARTED       NaN  5a6c7e44fd2cc626d9008b60               web   
90       screen_view       NaN  5a6c7e44fd2cc626d9008b60              auto   
91       screen_view       NaN  5a6c7e44fd2cc626d9008b60              auto   
92        web_remove       NaN  5a6c7e44fd2cc626d9008b60              auto   
93       SELECT_LANG       NaN  5a6c7e44fd2cc626d9008b61               web   
94        first_open       NaN  5a6c7e44fd2cc626d9008b62              auto   
95       screen_view       NaN  5a6c7e44fd2cc626d9008b62              auto   
96     kns__campaign       NaN  5a6c7e44fd2cc626d9008b62              auto   
97           SIGN_IN  146482.0  5a6c7e44fd2cc626d9008b63               web   
98       SELECT_LANG       NaN  5a6c7e44fd2cc626d9008b64               web   
99       screen_view       NaN  5a6c7e44fd2cc626d9008b64              auto   
100      screen_view       NaN  5a6c7e44fd2cc626d9008b64              auto   
101      screen_view       NaN  5a6c7e44fd2cc626d9008b64              auto   

     source kns__previous_class  
0       NaN                 NaN  
1       NaN                 NaN  
2       NaN                 NaN  
3       NaN                 NaN  
4       NaN                 NaN  
5       NaN       LoginActivity  
6       NaN                 NaN  
7       NaN                 NaN  
8       NaN                 NaN  
9       NaN       LoginActivity  
10      NaN                 NaN  
11      NaN       LoginActivity  
12      NaN     WebviewActivity  
13      NaN                 NaN  
14      NaN       LoginActivity  
15      NaN     WebviewActivity  
16      NaN                 NaN  
17      NaN                 NaN  
18      NaN                 NaN  
19      NaN                 NaN  
20      NaN       LoginActivity  
21      NaN                 NaN  
22      NaN   SignInHubActivity  
23      NaN                 NaN  
24      NaN                 NaN  
25      NaN           Dashboard  
26      NaN                 NaN  
27      NaN                 NaN  
28      NaN                 NaN  
29       SC                 NaN  
..      ...                 ...  
72      NaN                 NaN  
73      NaN                 NaN  
74      NaN                 NaN  
75      NaN                 NaN  
76      NaN       LoginActivity  
77      NaN                 NaN  
78      NaN                 NaN  
79      NaN                 NaN  
80       SC                 NaN  
81      NaN                 NaN  
82      NaN                 NaN  
83      NaN                 NaN  
84      NaN       LoginActivity  
85      NaN                 NaN  
86    Email                 NaN  
87      NaN       LoginActivity  
88      NaN                 NaN  
89      NaN                 NaN  
90      NaN           Dashboard  
91      NaN                 NaN  
92      NaN                 NaN  
93      NaN                 NaN  
94      NaN                 NaN  
95      NaN                 NaN  
96   google                 NaN  
97      NaN                 NaN  
98      NaN                 NaN  
99      NaN       LoginActivity  
100     NaN       LoginActivity  
101     NaN   SignInHubActivity  

[102 rows x 13 columns]
>>> df.columns
Index(['campaign', 'medium', 'instance_id', 'timestamp_micros',
       'kns__screen_class', 'kns_lid', 'kns__conversion', 'name', 'userId',
       '_id', 'kns__event_origin', 'source', 'kns__previous_class'],
      dtype='object')
>>> df.columns()
Traceback (most recent call last):
  File "<pyshell#7>", line 1, in <module>
    df.columns()
TypeError: 'Index' object is not callable
>>> df.columns
Index(['campaign', 'medium', 'instance_id', 'timestamp_micros',
       'kns__screen_class', 'kns_lid', 'kns__conversion', 'name', 'userId',
       '_id', 'kns__event_origin', 'source', 'kns__previous_class'],
      dtype='object')
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
dtype: object
>>> 
>>> 



>>> 

>>> 

>>> 
>>> dir()
['__annotations__', '__builtins__', '__doc__', '__loader__', '__name__', '__package__', '__spec__', 'df', 'pd']
>>> help()

Welcome to Python 3.6's help utility!

If this is your first time using Python, you should definitely check out
the tutorial on the Internet at http://docs.python.org/3.6/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To quit this help utility and
return to the interpreter, just type "quit".

To get a list of available modules, keywords, symbols, or topics, type
"modules", "keywords", "symbols", or "topics".  Each module also comes
with a one-line summary of what it does; to list the modules whose name
or summary contain a given string such as "spam", type "modules spam".

help> modules

Please wait a moment while I gather a list of all available modules...


Warning (from warnings module):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\IPython\kernel\__init__.py", line 13
    "You should import from ipykernel or jupyter_client instead.", ShimWarning)
ShimWarning: The `IPython.kernel` package has been deprecated since IPython 4.0.You should import from ipykernel or jupyter_client instead.

=============================== RESTART: Shell ===============================
>>> modules
Traceback (most recent call last):
  File "<pyshell#17>", line 1, in <module>
    modules
NameError: name 'modules' is not defined
>>> help()

Welcome to Python 3.6's help utility!

If this is your first time using Python, you should definitely check out
the tutorial on the Internet at http://docs.python.org/3.6/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To quit this help utility and
return to the interpreter, just type "quit".

To get a list of available modules, keywords, symbols, or topics, type
"modules", "keywords", "symbols", or "topics".  Each module also comes
with a one-line summary of what it does; to list the modules whose name
or summary contain a given string such as "spam", type "modules spam".

help> modules

Please wait a moment while I gather a list of all available modules...


Warning (from warnings module):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\IPython\kernel\__init__.py", line 13
    "You should import from ipykernel or jupyter_client instead.", ShimWarning)
ShimWarning: The `IPython.kernel` package has been deprecated since IPython 4.0.You should import from ipykernel or jupyter_client instead.

=============================== RESTART: Shell ===============================
>>> df
Traceback (most recent call last):
  File "<pyshell#19>", line 1, in <module>
    df
NameError: name 'df' is not defined
>>> df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
Traceback (most recent call last):
  File "<pyshell#20>", line 1, in <module>
    df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
NameError: name 'pd' is not defined
>>> import pandas as pd
>>> df=pd.read_excel("F:\\SAS\\sample_data_module1.xlsx",sheet_name=0)
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
dtype: object
>>> df['datetime_stamp']=float(timestamp_micros/1000000)
Traceback (most recent call last):
  File "<pyshell#24>", line 1, in <module>
    df['datetime_stamp']=float(timestamp_micros/1000000)
NameError: name 'timestamp_micros' is not defined
>>> df['datetime_stamp']=float(df['timestamp_micros']/1000000)
Traceback (most recent call last):
  File "<pyshell#25>", line 1, in <module>
    df['datetime_stamp']=float(df['timestamp_micros']/1000000)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\series.py", line 112, in wrapper
    "{0}".format(str(converter)))
TypeError: cannot convert the series to <class 'float'>
>>> df['datetime_stamp']=df['timestamp_micros']/1000000
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
datetime_stamp         float64
dtype: object
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class  datetime_stamp  
0              auto    NaN                 NaN    1.514091e+09  
1              auto    NaN                 NaN    1.514091e+09  
2              auto    NaN                 NaN    1.514091e+09  
3               web    NaN                 NaN    1.514091e+09  
4               web    NaN                 NaN    1.514091e+09  
>>> df['datetime_stamp']=df['datetime_stamp'] + 315619200
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class  datetime_stamp  
0              auto    NaN                 NaN    1.829710e+09  
1              auto    NaN                 NaN    1.829710e+09  
2              auto    NaN                 NaN    1.829710e+09  
3               web    NaN                 NaN    1.829710e+09  
4               web    NaN                 NaN    1.829710e+09  
>>> import time
>>> time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(1514091286.07))
'2017-12-24 04:54:46'
>>> df['datetime_stamp']=time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(df['datetime_stamp']))
Traceback (most recent call last):
  File "<pyshell#33>", line 1, in <module>
    df['datetime_stamp']=time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(df['datetime_stamp']))
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\series.py", line 112, in wrapper
    "{0}".format(str(converter)))
TypeError: cannot convert the series to <class 'int'>
>>> type(df['datetime_stamp'])
<class 'pandas.core.series.Series'>
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
datetime_stamp         float64
dtype: object
>>> df['datetime_stamp'][0]
1829710486.07
>>> time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(df['datetime_stamp'][0]))
'2027-12-25 04:54:46'
>>> for i in list(df['datetime_stamp']):
	print(i)

	
1829710486.07
1829710466.503
1829710469.153
1829710474.303
1829710474.468
1829710476.243
1829710479.662
1829710738.197
1829710585.909
1829710586.142
1829710591.092
1829710591.246
1829710623.59
1829710626.726
1829710626.939
1829710631.79601
1829156010.071
1829193461.286
1829193461.432
1829193463.997
1829193464.252
1829193471.127
1829156037.073
1829156040.212
1829156086.468
1829156086.633
1829156152.992
1829156006.861
1829156007.758
1829156008.26
1829156010.105
1829156010.31
1829156017.045
1829156055.458
1829156055.705
1829643137.745
1829642450.34
1829642450.454
1829642452.32
1829642452.563
1829642592.594
1829642478.813
1829642565.068
1829214573.351
1829214584.794
1829214601.91801
1829214653.26701
1829214882.052
1829214894.55901
1829214984.44701
1829235435.303
1829235435.446
1829235438.073
1829235438.5
1829235445.842
1829214488.635
1829214488.78
1829214491.482
1829214491.925
1829214499.216
1829157735.324
1829157763.75201
1829157768.08901
1829157665.59
1829235476.354
1829157152.041
1829214689.15401
1829157152.27
1829157152.439
1829157155.463
1829235674.936
1829235820.99701
1829157206.193
1829157206.614
1829157165.088
1829157173.598
1829157174.547
1829157180.41
1829157148.625
1829157149.393
1829157150.993
1829326837.188
1829326837.331
1829326839.56
1829326839.951
1829326847.678
1829326837.123
1829289905.266
1829289912.841
1829289931.109
1829289931.344
1829289954.01601
1829289961.27201
1829289893.846
1829289891.952
1829289892.359
1829289892.808
1829289904.849
1829289893.878
1829289894.015
1829289896.106
1829289899.924
>>> k=[]
>>> for i in list(df['datetime_stamp']):
	k.append(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(i)))

	
>>> k
['2027-12-25 04:54:46', '2027-12-25 04:54:26', '2027-12-25 04:54:29', '2027-12-25 04:54:34', '2027-12-25 04:54:34', '2027-12-25 04:54:36', '2027-12-25 04:54:39', '2027-12-25 04:58:58', '2027-12-25 04:56:25', '2027-12-25 04:56:26', '2027-12-25 04:56:31', '2027-12-25 04:56:31', '2027-12-25 04:57:03', '2027-12-25 04:57:06', '2027-12-25 04:57:06', '2027-12-25 04:57:11', '2027-12-18 18:53:30', '2027-12-19 05:17:41', '2027-12-19 05:17:41', '2027-12-19 05:17:43', '2027-12-19 05:17:44', '2027-12-19 05:17:51', '2027-12-18 18:53:57', '2027-12-18 18:54:00', '2027-12-18 18:54:46', '2027-12-18 18:54:46', '2027-12-18 18:55:52', '2027-12-18 18:53:26', '2027-12-18 18:53:27', '2027-12-18 18:53:28', '2027-12-18 18:53:30', '2027-12-18 18:53:30', '2027-12-18 18:53:37', '2027-12-18 18:54:15', '2027-12-18 18:54:15', '2027-12-24 10:12:17', '2027-12-24 10:00:50', '2027-12-24 10:00:50', '2027-12-24 10:00:52', '2027-12-24 10:00:52', '2027-12-24 10:03:12', '2027-12-24 10:01:18', '2027-12-24 10:02:45', '2027-12-19 11:09:33', '2027-12-19 11:09:44', '2027-12-19 11:10:01', '2027-12-19 11:10:53', '2027-12-19 11:14:42', '2027-12-19 11:14:54', '2027-12-19 11:16:24', '2027-12-19 16:57:15', '2027-12-19 16:57:15', '2027-12-19 16:57:18', '2027-12-19 16:57:18', '2027-12-19 16:57:25', '2027-12-19 11:08:08', '2027-12-19 11:08:08', '2027-12-19 11:08:11', '2027-12-19 11:08:11', '2027-12-19 11:08:19', '2027-12-18 19:22:15', '2027-12-18 19:22:43', '2027-12-18 19:22:48', '2027-12-18 19:21:05', '2027-12-19 16:57:56', '2027-12-18 19:12:32', '2027-12-19 11:11:29', '2027-12-18 19:12:32', '2027-12-18 19:12:32', '2027-12-18 19:12:35', '2027-12-19 17:01:14', '2027-12-19 17:03:40', '2027-12-18 19:13:26', '2027-12-18 19:13:26', '2027-12-18 19:12:45', '2027-12-18 19:12:53', '2027-12-18 19:12:54', '2027-12-18 19:13:00', '2027-12-18 19:12:28', '2027-12-18 19:12:29', '2027-12-18 19:12:30', '2027-12-20 18:20:37', '2027-12-20 18:20:37', '2027-12-20 18:20:39', '2027-12-20 18:20:39', '2027-12-20 18:20:47', '2027-12-20 18:20:37', '2027-12-20 08:05:05', '2027-12-20 08:05:12', '2027-12-20 08:05:31', '2027-12-20 08:05:31', '2027-12-20 08:05:54', '2027-12-20 08:06:01', '2027-12-20 08:04:53', '2027-12-20 08:04:51', '2027-12-20 08:04:52', '2027-12-20 08:04:52', '2027-12-20 08:05:04', '2027-12-20 08:04:53', '2027-12-20 08:04:54', '2027-12-20 08:04:56', '2027-12-20 08:04:59']
>>> len(k)
102
>>> 
>>> 
>>> 
>>> d=pd.DataFrame(k)
>>> d
                       0
0    2027-12-25 04:54:46
1    2027-12-25 04:54:26
2    2027-12-25 04:54:29
3    2027-12-25 04:54:34
4    2027-12-25 04:54:34
5    2027-12-25 04:54:36
6    2027-12-25 04:54:39
7    2027-12-25 04:58:58
8    2027-12-25 04:56:25
9    2027-12-25 04:56:26
10   2027-12-25 04:56:31
11   2027-12-25 04:56:31
12   2027-12-25 04:57:03
13   2027-12-25 04:57:06
14   2027-12-25 04:57:06
15   2027-12-25 04:57:11
16   2027-12-18 18:53:30
17   2027-12-19 05:17:41
18   2027-12-19 05:17:41
19   2027-12-19 05:17:43
20   2027-12-19 05:17:44
21   2027-12-19 05:17:51
22   2027-12-18 18:53:57
23   2027-12-18 18:54:00
24   2027-12-18 18:54:46
25   2027-12-18 18:54:46
26   2027-12-18 18:55:52
27   2027-12-18 18:53:26
28   2027-12-18 18:53:27
29   2027-12-18 18:53:28
..                   ...
72   2027-12-18 19:13:26
73   2027-12-18 19:13:26
74   2027-12-18 19:12:45
75   2027-12-18 19:12:53
76   2027-12-18 19:12:54
77   2027-12-18 19:13:00
78   2027-12-18 19:12:28
79   2027-12-18 19:12:29
80   2027-12-18 19:12:30
81   2027-12-20 18:20:37
82   2027-12-20 18:20:37
83   2027-12-20 18:20:39
84   2027-12-20 18:20:39
85   2027-12-20 18:20:47
86   2027-12-20 18:20:37
87   2027-12-20 08:05:05
88   2027-12-20 08:05:12
89   2027-12-20 08:05:31
90   2027-12-20 08:05:31
91   2027-12-20 08:05:54
92   2027-12-20 08:06:01
93   2027-12-20 08:04:53
94   2027-12-20 08:04:51
95   2027-12-20 08:04:52
96   2027-12-20 08:04:52
97   2027-12-20 08:05:04
98   2027-12-20 08:04:53
99   2027-12-20 08:04:54
100  2027-12-20 08:04:56
101  2027-12-20 08:04:59

[102 rows x 1 columns]
>>> type(d)
<class 'pandas.core.frame.DataFrame'>
>>> df['datetime_stamp']=d
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class       datetime_stamp  
0              auto    NaN                 NaN  2027-12-25 04:54:46  
1              auto    NaN                 NaN  2027-12-25 04:54:26  
2              auto    NaN                 NaN  2027-12-25 04:54:29  
3               web    NaN                 NaN  2027-12-25 04:54:34  
4               web    NaN                 NaN  2027-12-25 04:54:34  
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
datetime_stamp          object
dtype: object
>>> s=list(df['datetime_stamp'])
>>> d
                       0
0    2027-12-25 04:54:46
1    2027-12-25 04:54:26
2    2027-12-25 04:54:29
3    2027-12-25 04:54:34
4    2027-12-25 04:54:34
5    2027-12-25 04:54:36
6    2027-12-25 04:54:39
7    2027-12-25 04:58:58
8    2027-12-25 04:56:25
9    2027-12-25 04:56:26
10   2027-12-25 04:56:31
11   2027-12-25 04:56:31
12   2027-12-25 04:57:03
13   2027-12-25 04:57:06
14   2027-12-25 04:57:06
15   2027-12-25 04:57:11
16   2027-12-18 18:53:30
17   2027-12-19 05:17:41
18   2027-12-19 05:17:41
19   2027-12-19 05:17:43
20   2027-12-19 05:17:44
21   2027-12-19 05:17:51
22   2027-12-18 18:53:57
23   2027-12-18 18:54:00
24   2027-12-18 18:54:46
25   2027-12-18 18:54:46
26   2027-12-18 18:55:52
27   2027-12-18 18:53:26
28   2027-12-18 18:53:27
29   2027-12-18 18:53:28
..                   ...
72   2027-12-18 19:13:26
73   2027-12-18 19:13:26
74   2027-12-18 19:12:45
75   2027-12-18 19:12:53
76   2027-12-18 19:12:54
77   2027-12-18 19:13:00
78   2027-12-18 19:12:28
79   2027-12-18 19:12:29
80   2027-12-18 19:12:30
81   2027-12-20 18:20:37
82   2027-12-20 18:20:37
83   2027-12-20 18:20:39
84   2027-12-20 18:20:39
85   2027-12-20 18:20:47
86   2027-12-20 18:20:37
87   2027-12-20 08:05:05
88   2027-12-20 08:05:12
89   2027-12-20 08:05:31
90   2027-12-20 08:05:31
91   2027-12-20 08:05:54
92   2027-12-20 08:06:01
93   2027-12-20 08:04:53
94   2027-12-20 08:04:51
95   2027-12-20 08:04:52
96   2027-12-20 08:04:52
97   2027-12-20 08:05:04
98   2027-12-20 08:04:53
99   2027-12-20 08:04:54
100  2027-12-20 08:04:56
101  2027-12-20 08:04:59

[102 rows x 1 columns]
>>> s
['2027-12-25 04:54:46', '2027-12-25 04:54:26', '2027-12-25 04:54:29', '2027-12-25 04:54:34', '2027-12-25 04:54:34', '2027-12-25 04:54:36', '2027-12-25 04:54:39', '2027-12-25 04:58:58', '2027-12-25 04:56:25', '2027-12-25 04:56:26', '2027-12-25 04:56:31', '2027-12-25 04:56:31', '2027-12-25 04:57:03', '2027-12-25 04:57:06', '2027-12-25 04:57:06', '2027-12-25 04:57:11', '2027-12-18 18:53:30', '2027-12-19 05:17:41', '2027-12-19 05:17:41', '2027-12-19 05:17:43', '2027-12-19 05:17:44', '2027-12-19 05:17:51', '2027-12-18 18:53:57', '2027-12-18 18:54:00', '2027-12-18 18:54:46', '2027-12-18 18:54:46', '2027-12-18 18:55:52', '2027-12-18 18:53:26', '2027-12-18 18:53:27', '2027-12-18 18:53:28', '2027-12-18 18:53:30', '2027-12-18 18:53:30', '2027-12-18 18:53:37', '2027-12-18 18:54:15', '2027-12-18 18:54:15', '2027-12-24 10:12:17', '2027-12-24 10:00:50', '2027-12-24 10:00:50', '2027-12-24 10:00:52', '2027-12-24 10:00:52', '2027-12-24 10:03:12', '2027-12-24 10:01:18', '2027-12-24 10:02:45', '2027-12-19 11:09:33', '2027-12-19 11:09:44', '2027-12-19 11:10:01', '2027-12-19 11:10:53', '2027-12-19 11:14:42', '2027-12-19 11:14:54', '2027-12-19 11:16:24', '2027-12-19 16:57:15', '2027-12-19 16:57:15', '2027-12-19 16:57:18', '2027-12-19 16:57:18', '2027-12-19 16:57:25', '2027-12-19 11:08:08', '2027-12-19 11:08:08', '2027-12-19 11:08:11', '2027-12-19 11:08:11', '2027-12-19 11:08:19', '2027-12-18 19:22:15', '2027-12-18 19:22:43', '2027-12-18 19:22:48', '2027-12-18 19:21:05', '2027-12-19 16:57:56', '2027-12-18 19:12:32', '2027-12-19 11:11:29', '2027-12-18 19:12:32', '2027-12-18 19:12:32', '2027-12-18 19:12:35', '2027-12-19 17:01:14', '2027-12-19 17:03:40', '2027-12-18 19:13:26', '2027-12-18 19:13:26', '2027-12-18 19:12:45', '2027-12-18 19:12:53', '2027-12-18 19:12:54', '2027-12-18 19:13:00', '2027-12-18 19:12:28', '2027-12-18 19:12:29', '2027-12-18 19:12:30', '2027-12-20 18:20:37', '2027-12-20 18:20:37', '2027-12-20 18:20:39', '2027-12-20 18:20:39', '2027-12-20 18:20:47', '2027-12-20 18:20:37', '2027-12-20 08:05:05', '2027-12-20 08:05:12', '2027-12-20 08:05:31', '2027-12-20 08:05:31', '2027-12-20 08:05:54', '2027-12-20 08:06:01', '2027-12-20 08:04:53', '2027-12-20 08:04:51', '2027-12-20 08:04:52', '2027-12-20 08:04:52', '2027-12-20 08:05:04', '2027-12-20 08:04:53', '2027-12-20 08:04:54', '2027-12-20 08:04:56', '2027-12-20 08:04:59']
>>> s[0][10]
' '
>>> s[0]
'2027-12-25 04:54:46'
>>> s[0][0:9]
'2027-12-2'
>>> s[0][0:10]
'2027-12-25'
>>> dir()
['__annotations__', '__builtins__', '__doc__', '__loader__', '__name__', '__package__', '__spec__', 'd', 'df', 'i', 'k', 'pd', 's', 'time']
>>> ddmmyyyy=[]
>>> for i in s:
	ddmmyyyy.append(i[0:10])

	
>>> ddmmyyyy
['2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-25', '2027-12-18', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-24', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-19', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-19', '2027-12-18', '2027-12-19', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-19', '2027-12-19', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-18', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20', '2027-12-20']
>>> len(ddmmyyyy)
102
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
datetime_stamp          object
dtype: object
>>> df['date_stamp']=pd.DataFrame(ddmmyyyy)
>>> df.dtypes
campaign                object
medium                  object
instance_id             object
timestamp_micros         int64
kns__screen_class       object
kns_lid                 object
kns__conversion         object
name                    object
userId                 float64
_id                     object
kns__event_origin       object
source                  object
kns__previous_class     object
datetime_stamp          object
date_stamp              object
dtype: object
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class       datetime_stamp  \
0              auto    NaN                 NaN  2027-12-25 04:54:46   
1              auto    NaN                 NaN  2027-12-25 04:54:26   
2              auto    NaN                 NaN  2027-12-25 04:54:29   
3               web    NaN                 NaN  2027-12-25 04:54:34   
4               web    NaN                 NaN  2027-12-25 04:54:34   

   date_stamp  
0  2027-12-25  
1  2027-12-25  
2  2027-12-25  
3  2027-12-25  
4  2027-12-25  
>>> df['datetime_stamp']=pd.to_datetime(df['datetime_stamp'])
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
timestamp_micros                int64
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp                     object
dtype: object
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class      datetime_stamp  date_stamp  
0              auto    NaN                 NaN 2027-12-25 04:54:46  2027-12-25  
1              auto    NaN                 NaN 2027-12-25 04:54:26  2027-12-25  
2              auto    NaN                 NaN 2027-12-25 04:54:29  2027-12-25  
3               web    NaN                 NaN 2027-12-25 04:54:34  2027-12-25  
4               web    NaN                 NaN 2027-12-25 04:54:34  2027-12-25  
>>> dir(pd)
['Categorical', 'CategoricalIndex', 'DataFrame', 'DateOffset', 'DatetimeIndex', 'ExcelFile', 'ExcelWriter', 'Expr', 'Float64Index', 'Grouper', 'HDFStore', 'Index', 'IndexSlice', 'Int64Index', 'Interval', 'IntervalIndex', 'MultiIndex', 'NaT', 'Panel', 'Panel4D', 'Period', 'PeriodIndex', 'RangeIndex', 'Series', 'SparseArray', 'SparseDataFrame', 'SparseList', 'SparseSeries', 'Term', 'TimeGrouper', 'Timedelta', 'TimedeltaIndex', 'Timestamp', 'UInt64Index', 'WidePanel', '_DeprecatedModule', '__builtins__', '__cached__', '__doc__', '__docformat__', '__file__', '__loader__', '__name__', '__package__', '__path__', '__spec__', '__version__', '_hashtable', '_lib', '_libs', '_np_version_under1p10', '_np_version_under1p11', '_np_version_under1p12', '_np_version_under1p13', '_np_version_under1p14', '_np_version_under1p15', '_tslib', '_version', 'api', 'bdate_range', 'compat', 'concat', 'core', 'crosstab', 'cut', 'date_range', 'datetime', 'datetools', 'describe_option', 'errors', 'eval', 'ewma', 'ewmcorr', 'ewmcov', 'ewmstd', 'ewmvar', 'ewmvol', 'expanding_apply', 'expanding_corr', 'expanding_count', 'expanding_cov', 'expanding_kurt', 'expanding_max', 'expanding_mean', 'expanding_median', 'expanding_min', 'expanding_quantile', 'expanding_skew', 'expanding_std', 'expanding_sum', 'expanding_var', 'factorize', 'get_dummies', 'get_option', 'get_store', 'groupby', 'infer_freq', 'interval_range', 'io', 'isna', 'isnull', 'json', 'lib', 'lreshape', 'match', 'melt', 'merge', 'merge_asof', 'merge_ordered', 'notna', 'notnull', 'np', 'offsets', 'option_context', 'options', 'ordered_merge', 'pandas', 'parser', 'period_range', 'pivot', 'pivot_table', 'plot_params', 'plotting', 'pnow', 'qcut', 'read_clipboard', 'read_csv', 'read_excel', 'read_feather', 'read_fwf', 'read_gbq', 'read_hdf', 'read_html', 'read_json', 'read_msgpack', 'read_parquet', 'read_pickle', 'read_sas', 'read_sql', 'read_sql_query', 'read_sql_table', 'read_stata', 'read_table', 'reset_option', 'rolling_apply', 'rolling_corr', 'rolling_count', 'rolling_cov', 'rolling_kurt', 'rolling_max', 'rolling_mean', 'rolling_median', 'rolling_min', 'rolling_quantile', 'rolling_skew', 'rolling_std', 'rolling_sum', 'rolling_var', 'rolling_window', 'scatter_matrix', 'set_eng_float_format', 'set_option', 'show_versions', 'stats', 'test', 'testing', 'timedelta_range', 'to_datetime', 'to_msgpack', 'to_numeric', 'to_pickle', 'to_timedelta', 'tools', 'tseries', 'tslib', 'unique', 'util', 'value_counts', 'wide_to_long']
>>> df['date_stamp']=pd.to_datetime(df['date_stamp'],format='%Y-%m-%d')
>>> df.dtypes()
Traceback (most recent call last):
  File "<pyshell#83>", line 1, in <module>
    df.dtypes()
TypeError: 'Series' object is not callable
>>> df.dtype
Traceback (most recent call last):
  File "<pyshell#84>", line 1, in <module>
    df.dtype
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 3614, in __getattr__
    return object.__getattribute__(self, name)
AttributeError: 'DataFrame' object has no attribute 'dtype'
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
timestamp_micros                int64
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> df.head()
  campaign medium                       instance_id  timestamp_micros  \
0      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091286070000   
1      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091266503000   
2      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091269153000   
3      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274303000   
4      NaN    NaN  000bff55caf956a6255365a5acca48f2  1514091274468000   

  kns__screen_class                                            kns_lid  \
0     LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1               NaN                                                NaN   
2     LoginActivity                                                NaN   
3     LoginActivity                                                NaN   
4               NaN                                                NaN   

  kns__conversion           name  userId                       _id  \
0               .  kns__campaign     NaN  5a6c7ef1fd2cc626d90322ad   
1               1     first_open     NaN  5a6c7ef1fd2cc626d90322ae   
2               .    screen_view     NaN  5a6c7ef1fd2cc626d90322ae   
3               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322af   
4               .    SELECT_LANG     NaN  5a6c7ef1fd2cc626d90322b0   

  kns__event_origin source kns__previous_class      datetime_stamp date_stamp  
0              auto    NaN                 NaN 2027-12-25 04:54:46 2027-12-25  
1              auto    NaN                 NaN 2027-12-25 04:54:26 2027-12-25  
2              auto    NaN                 NaN 2027-12-25 04:54:29 2027-12-25  
3               web    NaN                 NaN 2027-12-25 04:54:34 2027-12-25  
4               web    NaN                 NaN 2027-12-25 04:54:34 2027-12-25  
>>> dir(df)
['T', '_AXIS_ALIASES', '_AXIS_IALIASES', '_AXIS_LEN', '_AXIS_NAMES', '_AXIS_NUMBERS', '_AXIS_ORDERS', '_AXIS_REVERSED', '_AXIS_SLICEMAP', '__abs__', '__add__', '__and__', '__array__', '__array_wrap__', '__bool__', '__bytes__', '__class__', '__contains__', '__copy__', '__deepcopy__', '__delattr__', '__delitem__', '__dict__', '__dir__', '__div__', '__doc__', '__eq__', '__finalize__', '__floordiv__', '__format__', '__ge__', '__getattr__', '__getattribute__', '__getitem__', '__getstate__', '__gt__', '__hash__', '__iadd__', '__iand__', '__ifloordiv__', '__imod__', '__imul__', '__init__', '__init_subclass__', '__invert__', '__ior__', '__ipow__', '__isub__', '__iter__', '__itruediv__', '__ixor__', '__le__', '__len__', '__lt__', '__mod__', '__module__', '__mul__', '__ne__', '__neg__', '__new__', '__nonzero__', '__or__', '__pow__', '__radd__', '__rand__', '__rdiv__', '__reduce__', '__reduce_ex__', '__repr__', '__rfloordiv__', '__rmod__', '__rmul__', '__ror__', '__round__', '__rpow__', '__rsub__', '__rtruediv__', '__rxor__', '__setattr__', '__setitem__', '__setstate__', '__sizeof__', '__str__', '__sub__', '__subclasshook__', '__truediv__', '__unicode__', '__weakref__', '__xor__', '_accessors', '_add_numeric_operations', '_add_series_only_operations', '_add_series_or_dataframe_operations', '_agg_by_level', '_agg_doc', '_aggregate', '_aggregate_multiple_funcs', '_align_frame', '_align_series', '_apply_broadcast', '_apply_empty_result', '_apply_raw', '_apply_standard', '_at', '_box_col_values', '_box_item_values', '_builtin_table', '_check_inplace_setting', '_check_is_chained_assignment_possible', '_check_percentile', '_check_setitem_copy', '_clear_item_cache', '_clip_with_one_bound', '_clip_with_scalar', '_combine_const', '_combine_frame', '_combine_match_columns', '_combine_match_index', '_combine_series', '_combine_series_infer', '_compare_frame', '_compare_frame_evaluate', '_consolidate', '_consolidate_inplace', '_construct_axes_dict', '_construct_axes_dict_for_slice', '_construct_axes_dict_from', '_construct_axes_from_arguments', '_constructor', '_constructor_expanddim', '_constructor_sliced', '_convert', '_count_level', '_create_indexer', '_cython_table', '_deprecations', '_dir_additions', '_dir_deletions', '_drop_axis', '_ensure_valid_index', '_expand_axes', '_flex_compare_frame', '_from_arrays', '_from_axes', '_get_agg_axis', '_get_axis', '_get_axis_name', '_get_axis_number', '_get_axis_resolvers', '_get_block_manager_axis', '_get_bool_data', '_get_cacher', '_get_index_resolvers', '_get_item_cache', '_get_numeric_data', '_get_valid_indices', '_get_value', '_get_values', '_getitem_array', '_getitem_column', '_getitem_frame', '_getitem_multilevel', '_getitem_slice', '_gotitem', '_iat', '_id', '_iget_item_cache', '_iloc', '_indexed_same', '_info_axis', '_info_axis_name', '_info_axis_number', '_info_repr', '_init_dict', '_init_mgr', '_init_ndarray', '_internal_names', '_internal_names_set', '_is_builtin_func', '_is_cached', '_is_cython_func', '_is_datelike_mixed_type', '_is_mixed_type', '_is_numeric_mixed_type', '_is_view', '_ix', '_ixs', '_join_compat', '_loc', '_maybe_cache_changed', '_maybe_update_cacher', '_metadata', '_needs_reindex_multi', '_obj_with_exclusions', '_protect_consolidate', '_reduce', '_reindex_axes', '_reindex_axis', '_reindex_columns', '_reindex_index', '_reindex_multi', '_reindex_with_indexers', '_repr_data_resource_', '_repr_fits_horizontal_', '_repr_fits_vertical_', '_repr_html_', '_repr_latex_', '_reset_cache', '_reset_cacher', '_sanitize_column', '_selected_obj', '_selection', '_selection_list', '_selection_name', '_series', '_set_as_cached', '_set_axis', '_set_axis_name', '_set_is_copy', '_set_item', '_set_value', '_setitem_array', '_setitem_frame', '_setitem_slice', '_setup_axes', '_shallow_copy', '_slice', '_stat_axis', '_stat_axis_name', '_stat_axis_number', '_take', '_to_dict_of_blocks', '_try_aggregate_string_function', '_typ', '_unpickle_frame_compat', '_unpickle_matrix_compat', '_update_inplace', '_validate_dtype', '_values', '_where', '_xs', 'abs', 'add', 'add_prefix', 'add_suffix', 'agg', 'aggregate', 'align', 'all', 'any', 'append', 'apply', 'applymap', 'as_matrix', 'asfreq', 'asof', 'assign', 'astype', 'at', 'at_time', 'axes', 'between_time', 'bfill', 'bool', 'boxplot', 'campaign', 'clip', 'clip_lower', 'clip_upper', 'columns', 'combine', 'combine_first', 'compound', 'copy', 'corr', 'corrwith', 'count', 'cov', 'cummax', 'cummin', 'cumprod', 'cumsum', 'date_stamp', 'datetime_stamp', 'describe', 'diff', 'div', 'divide', 'dot', 'drop', 'drop_duplicates', 'dropna', 'dtypes', 'duplicated', 'empty', 'eq', 'equals', 'eval', 'ewm', 'expanding', 'ffill', 'fillna', 'filter', 'first', 'first_valid_index', 'floordiv', 'from_dict', 'from_items', 'from_records', 'ftypes', 'ge', 'get', 'get_dtype_counts', 'get_ftype_counts', 'get_values', 'groupby', 'gt', 'head', 'hist', 'iat', 'idxmax', 'idxmin', 'iloc', 'index', 'infer_objects', 'info', 'insert', 'instance_id', 'interpolate', 'is_copy', 'isin', 'isna', 'isnull', 'items', 'iteritems', 'iterrows', 'itertuples', 'ix', 'join', 'keys', 'kns__conversion', 'kns__event_origin', 'kns__previous_class', 'kns__screen_class', 'kns_lid', 'kurt', 'kurtosis', 'last', 'last_valid_index', 'le', 'loc', 'lookup', 'lt', 'mad', 'mask', 'max', 'mean', 'median', 'medium', 'melt', 'memory_usage', 'merge', 'min', 'mod', 'mode', 'mul', 'multiply', 'name', 'ndim', 'ne', 'nlargest', 'notna', 'notnull', 'nsmallest', 'nunique', 'pct_change', 'pipe', 'pivot', 'pivot_table', 'plot', 'pop', 'pow', 'prod', 'product', 'quantile', 'query', 'radd', 'rank', 'rdiv', 'reindex', 'reindex_axis', 'reindex_like', 'rename', 'rename_axis', 'reorder_levels', 'replace', 'resample', 'reset_index', 'rfloordiv', 'rmod', 'rmul', 'rolling', 'round', 'rpow', 'rsub', 'rtruediv', 'sample', 'select', 'select_dtypes', 'sem', 'set_axis', 'set_index', 'shape', 'shift', 'size', 'skew', 'slice_shift', 'sort_index', 'sort_values', 'source', 'squeeze', 'stack', 'std', 'style', 'sub', 'subtract', 'sum', 'swapaxes', 'swaplevel', 'tail', 'take', 'timestamp_micros', 'to_clipboard', 'to_csv', 'to_dense', 'to_dict', 'to_excel', 'to_feather', 'to_gbq', 'to_hdf', 'to_html', 'to_json', 'to_latex', 'to_msgpack', 'to_panel', 'to_parquet', 'to_period', 'to_pickle', 'to_records', 'to_sparse', 'to_sql', 'to_stata', 'to_string', 'to_timestamp', 'to_xarray', 'transform', 'transpose', 'truediv', 'truncate', 'tshift', 'tz_convert', 'tz_localize', 'unstack', 'update', 'userId', 'values', 'var', 'where', 'xs']
>>> df.dtype
Traceback (most recent call last):
  File "<pyshell#88>", line 1, in <module>
    df.dtype
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 3614, in __getattr__
    return object.__getattribute__(self, name)
AttributeError: 'DataFrame' object has no attribute 'dtype'
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
timestamp_micros                int64
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> df.drop('timestamp_micros')
Traceback (most recent call last):
  File "<pyshell#90>", line 1, in <module>
    df.drop('timestamp_micros')
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 2530, in drop
    obj = obj._drop_axis(labels, axis, level=level, errors=errors)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 2562, in _drop_axis
    new_axis = axis.drop(labels, errors=errors)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 3744, in drop
    labels[mask])
ValueError: labels ['timestamp_micros'] not contained in axis
>>> del df['timestamp_micros']
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> df.rename(columns={'name'='event_name'})
SyntaxError: invalid syntax
>>> df.rename(columns={'name':'event_name'})
         campaign     medium                       instance_id  \
0             NaN        NaN  000bff55caf956a6255365a5acca48f2   
1             NaN        NaN  000bff55caf956a6255365a5acca48f2   
2             NaN        NaN  000bff55caf956a6255365a5acca48f2   
3             NaN        NaN  000bff55caf956a6255365a5acca48f2   
4             NaN        NaN  000bff55caf956a6255365a5acca48f2   
5             NaN        NaN  000bff55caf956a6255365a5acca48f2   
6             NaN        NaN  000bff55caf956a6255365a5acca48f2   
7             NaN        NaN  000bff55caf956a6255365a5acca48f2   
8             NaN        NaN  000bff55caf956a6255365a5acca48f2   
9             NaN        NaN  000bff55caf956a6255365a5acca48f2   
10            NaN        NaN  000bff55caf956a6255365a5acca48f2   
11            NaN        NaN  000bff55caf956a6255365a5acca48f2   
12            NaN        NaN  000bff55caf956a6255365a5acca48f2   
13            NaN        NaN  000bff55caf956a6255365a5acca48f2   
14            NaN        NaN  000bff55caf956a6255365a5acca48f2   
15            NaN        NaN  000bff55caf956a6255365a5acca48f2   
16            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
17            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
18            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
19            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
20            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
21            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
22            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
23            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
24            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
25            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
26            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
27            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
28            NaN        NaN  001d7324e01e1e8e063fa976c2fabc25   
29             c3        NaN  001d7324e01e1e8e063fa976c2fabc25   
..            ...        ...                               ...   
72            NaN        NaN  00225f1f30f3584e9600364280825ba6   
73            NaN        NaN  00225f1f30f3584e9600364280825ba6   
74            NaN        NaN  00225f1f30f3584e9600364280825ba6   
75            NaN        NaN  00225f1f30f3584e9600364280825ba6   
76            NaN        NaN  00225f1f30f3584e9600364280825ba6   
77            NaN        NaN  00225f1f30f3584e9600364280825ba6   
78            NaN        NaN  00225f1f30f3584e9600364280825ba6   
79            NaN        NaN  00225f1f30f3584e9600364280825ba6   
80             c3        NaN  00225f1f30f3584e9600364280825ba6   
81            NaN        NaN  00225f1f30f3584e9600364280825ba6   
82            NaN        NaN  00225f1f30f3584e9600364280825ba6   
83            NaN        NaN  00225f1f30f3584e9600364280825ba6   
84            NaN        NaN  00225f1f30f3584e9600364280825ba6   
85            NaN        NaN  00225f1f30f3584e9600364280825ba6   
86   personalinfo  Reminders  00225f1f30f3584e9600364280825ba6   
87            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
88            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
89            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
90            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
91            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
92            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
93            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
94            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
95            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
96            NaN    organic  01096799fcc6780dd275c71e6c6e1571   
97            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
98            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
99            NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
100           NaN        NaN  01096799fcc6780dd275c71e6c6e1571   
101           NaN        NaN  01096799fcc6780dd275c71e6c6e1571   

     kns__screen_class                                            kns_lid  \
0        LoginActivity  EAIaIQobChMI7ZjekO2h2AIVDtOOCh3Yxw1GEAEYASAAEg...   
1                  NaN                                                NaN   
2        LoginActivity                                                NaN   
3        LoginActivity                                                NaN   
4                  NaN                                                NaN   
5        LoginActivity                                                NaN   
6        LoginActivity                                                NaN   
7                  NaN                                                NaN   
8                  NaN                                                NaN   
9        LoginActivity                                                NaN   
10                 NaN                                                NaN   
11     WebviewActivity                                                NaN   
12       LoginActivity                                                NaN   
13                 NaN                                                NaN   
14     WebviewActivity                                                NaN   
15       LoginActivity                                                NaN   
16       LoginActivity                                                NaN   
17                 NaN                                                NaN   
18       LoginActivity                                                NaN   
19       LoginActivity                                                NaN   
20           Dashboard                                                NaN   
21           Dashboard                                                NaN   
22       LoginActivity                                                NaN   
23       LoginActivity                                                NaN   
24           Dashboard                                                NaN   
25           Dashboard                                                NaN   
26           Dashboard                                                NaN   
27                 NaN                                                NaN   
28       LoginActivity                                                NaN   
29       LoginActivity                                                NaN   
..                 ...                                                ...   
72           Dashboard                                                NaN   
73           Dashboard                                                NaN   
74       LoginActivity                                                NaN   
75                 NaN                                                NaN   
76           Dashboard                                                NaN   
77           Dashboard                                                NaN   
78                 NaN                                                NaN   
79       LoginActivity                                                NaN   
80       LoginActivity                                                NaN   
81                 NaN                                                NaN   
82       LoginActivity                                                NaN   
83       LoginActivity                                                NaN   
84           Dashboard                                                NaN   
85           Dashboard                                                NaN   
86                 NaN                                                NaN   
87           Dashboard                                                NaN   
88           Dashboard                                                NaN   
89           Dashboard                                                NaN   
90           Dashboard                                                NaN   
91           Dashboard                                                NaN   
92                 NaN                                                NaN   
93       LoginActivity                                                NaN   
94                 NaN                                                NaN   
95       LoginActivity                                                NaN   
96       LoginActivity                                                NaN   
97                 NaN                                                NaN   
98                 NaN                                                NaN   
99       LoginActivity                                                NaN   
100  SignInHubActivity                                                NaN   
101      LoginActivity                                                NaN   

    kns__conversion       event_name    userId                       _id  \
0                 .    kns__campaign       NaN  5a6c7ef1fd2cc626d90322ad   
1                 1       first_open       NaN  5a6c7ef1fd2cc626d90322ae   
2                 .      screen_view       NaN  5a6c7ef1fd2cc626d90322ae   
3                 .      SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322af   
4                 .      SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322b0   
5                 .      screen_view       NaN  5a6c7ef1fd2cc626d90322b0   
6                 1    session_start       NaN  5a6c7ef1fd2cc626d90322b0   
7                 .       web_remove       NaN  5a6c7ef1fd2cc626d90322b1   
8                 .      SELECT_LANG       NaN  5a6c7ef1fd2cc626d90322b2   
9                 .      screen_view       NaN  5a6c7ef1fd2cc626d90322b2   
10                .     HOW_IT_WORKS       NaN  5a6c7ef1fd2cc626d90322b2   
11                .      screen_view       NaN  5a6c7ef1fd2cc626d90322b2   
12                .      screen_view       NaN  5a6c7ef1fd2cc626d90322b2   
13                .     HOW_IT_WORKS       NaN  5a6c7ef1fd2cc626d90322b2   
14                .      screen_view       NaN  5a6c7ef1fd2cc626d90322b2   
15                .      screen_view       NaN  5a6c7ef1fd2cc626d90322b2   
16                .      SELECT_LANG       NaN  5a6c7e22fd2cc626d9001159   
17                .      SELECT_LANG       NaN  5a6c7e22fd2cc626d900115a   
18                .      screen_view       NaN  5a6c7e22fd2cc626d900115a   
19                1          SIGN_IN  144741.0  5a6c7e22fd2cc626d900115a   
20                .      screen_view       NaN  5a6c7e22fd2cc626d900115a   
21                .      screen_view       NaN  5a6c7e22fd2cc626d900115a   
22                .      screen_view       NaN  5a6c7e22fd2cc626d900115b   
23                1    session_start       NaN  5a6c7e22fd2cc626d900115b   
24                .  GETTING_STARTED       NaN  5a6c7e22fd2cc626d900115c   
25                .      screen_view       NaN  5a6c7e22fd2cc626d900115c   
26                .      screen_view       NaN  5a6c7e22fd2cc626d900115c   
27                1       first_open       NaN  5a6c7e22fd2cc626d900115d   
28                .      screen_view       NaN  5a6c7e22fd2cc626d900115d   
29                .    kns__campaign       NaN  5a6c7e22fd2cc626d900115d   
..              ...              ...       ...                       ...   
72                .  GETTING_STARTED       NaN  5a6c7e18fd2cc626d9ffe559   
73                .      screen_view       NaN  5a6c7e18fd2cc626d9ffe559   
74                .      screen_view       NaN  5a6c7e18fd2cc626d9ffe55a   
75                1          SIGN_IN  144754.0  5a6c7e18fd2cc626d9ffe55a   
76                .      screen_view       NaN  5a6c7e18fd2cc626d9ffe55a   
77                1    session_start       NaN  5a6c7e18fd2cc626d9ffe55a   
78                1       first_open       NaN  5a6c7e18fd2cc626d9ffe55c   
79                .      screen_view       NaN  5a6c7e18fd2cc626d9ffe55c   
80                .    kns__campaign       NaN  5a6c7e18fd2cc626d9ffe55c   
81                .      SELECT_LANG       NaN  5a6c7e42fd2cc626d90083e1   
82                .      screen_view       NaN  5a6c7e42fd2cc626d90083e1   
83                1          SIGN_IN  144754.0  5a6c7e42fd2cc626d90083e1   
84                .      screen_view       NaN  5a6c7e42fd2cc626d90083e1   
85                1    session_start       NaN  5a6c7e42fd2cc626d90083e1   
86                .    kns__campaign       NaN  5a6c7e42fd2cc626d90083e2   
87                .      screen_view       NaN  5a6c7e44fd2cc626d9008b5f   
88                1    session_start       NaN  5a6c7e44fd2cc626d9008b5f   
89                .  GETTING_STARTED       NaN  5a6c7e44fd2cc626d9008b60   
90                .      screen_view       NaN  5a6c7e44fd2cc626d9008b60   
91                .      screen_view       NaN  5a6c7e44fd2cc626d9008b60   
92                .       web_remove       NaN  5a6c7e44fd2cc626d9008b60   
93                .      SELECT_LANG       NaN  5a6c7e44fd2cc626d9008b61   
94                1       first_open       NaN  5a6c7e44fd2cc626d9008b62   
95                .      screen_view       NaN  5a6c7e44fd2cc626d9008b62   
96                .    kns__campaign       NaN  5a6c7e44fd2cc626d9008b62   
97                1          SIGN_IN  146482.0  5a6c7e44fd2cc626d9008b63   
98                .      SELECT_LANG       NaN  5a6c7e44fd2cc626d9008b64   
99                .      screen_view       NaN  5a6c7e44fd2cc626d9008b64   
100               .      screen_view       NaN  5a6c7e44fd2cc626d9008b64   
101               .      screen_view       NaN  5a6c7e44fd2cc626d9008b64   

    kns__event_origin  source kns__previous_class      datetime_stamp  \
0                auto     NaN                 NaN 2027-12-25 04:54:46   
1                auto     NaN                 NaN 2027-12-25 04:54:26   
2                auto     NaN                 NaN 2027-12-25 04:54:29   
3                 web     NaN                 NaN 2027-12-25 04:54:34   
4                 web     NaN                 NaN 2027-12-25 04:54:34   
5                auto     NaN       LoginActivity 2027-12-25 04:54:36   
6                auto     NaN                 NaN 2027-12-25 04:54:39   
7                auto     NaN                 NaN 2027-12-25 04:58:58   
8                 web     NaN                 NaN 2027-12-25 04:56:25   
9                auto     NaN       LoginActivity 2027-12-25 04:56:26   
10                web     NaN                 NaN 2027-12-25 04:56:31   
11               auto     NaN       LoginActivity 2027-12-25 04:56:31   
12               auto     NaN     WebviewActivity 2027-12-25 04:57:03   
13                web     NaN                 NaN 2027-12-25 04:57:06   
14               auto     NaN       LoginActivity 2027-12-25 04:57:06   
15               auto     NaN     WebviewActivity 2027-12-25 04:57:11   
16                web     NaN                 NaN 2027-12-18 18:53:30   
17                web     NaN                 NaN 2027-12-19 05:17:41   
18               auto     NaN                 NaN 2027-12-19 05:17:41   
19                web     NaN                 NaN 2027-12-19 05:17:43   
20               auto     NaN       LoginActivity 2027-12-19 05:17:44   
21               auto     NaN                 NaN 2027-12-19 05:17:51   
22               auto     NaN   SignInHubActivity 2027-12-18 18:53:57   
23               auto     NaN                 NaN 2027-12-18 18:54:00   
24                web     NaN                 NaN 2027-12-18 18:54:46   
25               auto     NaN           Dashboard 2027-12-18 18:54:46   
26               auto     NaN                 NaN 2027-12-18 18:55:52   
27               auto     NaN                 NaN 2027-12-18 18:53:26   
28               auto     NaN                 NaN 2027-12-18 18:53:27   
29               auto      SC                 NaN 2027-12-18 18:53:28   
..                ...     ...                 ...                 ...   
72                web     NaN                 NaN 2027-12-18 19:13:26   
73               auto     NaN                 NaN 2027-12-18 19:13:26   
74               auto     NaN                 NaN 2027-12-18 19:12:45   
75                web     NaN                 NaN 2027-12-18 19:12:53   
76               auto     NaN       LoginActivity 2027-12-18 19:12:54   
77               auto     NaN                 NaN 2027-12-18 19:13:00   
78               auto     NaN                 NaN 2027-12-18 19:12:28   
79               auto     NaN                 NaN 2027-12-18 19:12:29   
80               auto      SC                 NaN 2027-12-18 19:12:30   
81                web     NaN                 NaN 2027-12-20 18:20:37   
82               auto     NaN                 NaN 2027-12-20 18:20:37   
83                web     NaN                 NaN 2027-12-20 18:20:39   
84               auto     NaN       LoginActivity 2027-12-20 18:20:39   
85               auto     NaN                 NaN 2027-12-20 18:20:47   
86               auto   Email                 NaN 2027-12-20 18:20:37   
87               auto     NaN       LoginActivity 2027-12-20 08:05:05   
88               auto     NaN                 NaN 2027-12-20 08:05:12   
89                web     NaN                 NaN 2027-12-20 08:05:31   
90               auto     NaN           Dashboard 2027-12-20 08:05:31   
91               auto     NaN                 NaN 2027-12-20 08:05:54   
92               auto     NaN                 NaN 2027-12-20 08:06:01   
93                web     NaN                 NaN 2027-12-20 08:04:53   
94               auto     NaN                 NaN 2027-12-20 08:04:51   
95               auto     NaN                 NaN 2027-12-20 08:04:52   
96               auto  google                 NaN 2027-12-20 08:04:52   
97                web     NaN                 NaN 2027-12-20 08:05:04   
98                web     NaN                 NaN 2027-12-20 08:04:53   
99               auto     NaN       LoginActivity 2027-12-20 08:04:54   
100              auto     NaN       LoginActivity 2027-12-20 08:04:56   
101              auto     NaN   SignInHubActivity 2027-12-20 08:04:59   

    date_stamp  
0   2027-12-25  
1   2027-12-25  
2   2027-12-25  
3   2027-12-25  
4   2027-12-25  
5   2027-12-25  
6   2027-12-25  
7   2027-12-25  
8   2027-12-25  
9   2027-12-25  
10  2027-12-25  
11  2027-12-25  
12  2027-12-25  
13  2027-12-25  
14  2027-12-25  
15  2027-12-25  
16  2027-12-18  
17  2027-12-19  
18  2027-12-19  
19  2027-12-19  
20  2027-12-19  
21  2027-12-19  
22  2027-12-18  
23  2027-12-18  
24  2027-12-18  
25  2027-12-18  
26  2027-12-18  
27  2027-12-18  
28  2027-12-18  
29  2027-12-18  
..         ...  
72  2027-12-18  
73  2027-12-18  
74  2027-12-18  
75  2027-12-18  
76  2027-12-18  
77  2027-12-18  
78  2027-12-18  
79  2027-12-18  
80  2027-12-18  
81  2027-12-20  
82  2027-12-20  
83  2027-12-20  
84  2027-12-20  
85  2027-12-20  
86  2027-12-20  
87  2027-12-20  
88  2027-12-20  
89  2027-12-20  
90  2027-12-20  
91  2027-12-20  
92  2027-12-20  
93  2027-12-20  
94  2027-12-20  
95  2027-12-20  
96  2027-12-20  
97  2027-12-20  
98  2027-12-20  
99  2027-12-20  
100 2027-12-20  
101 2027-12-20  

[102 rows x 14 columns]
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> use_events=df['instance_id','_id','userid','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']
Traceback (most recent call last):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2525, in get_loc
    return self._engine.get_loc(key)
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: ('instance_id', '_id', 'userid', 'kns_lid', 'name', 'kns__screen_class', 'kns__previous_class', 'campaign', 'medium', 'source', 'kns__conversion', 'kns__event_origin', 'datetime_stamp', 'date_stamp')

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<pyshell#96>", line 1, in <module>
    use_events=df['instance_id','_id','userid','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2139, in __getitem__
    return self._getitem_column(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2146, in _getitem_column
    return self._get_item_cache(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 1842, in _get_item_cache
    values = self._data.get(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\internals.py", line 3843, in get
    loc = self.items.get_loc(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2527, in get_loc
    return self._engine.get_loc(self._maybe_cast_indexer(key))
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: ('instance_id', '_id', 'userid', 'kns_lid', 'name', 'kns__screen_class', 'kns__previous_class', 'campaign', 'medium', 'source', 'kns__conversion', 'kns__event_origin', 'datetime_stamp', 'date_stamp')
>>> user_events=df['instance_id','_id']
Traceback (most recent call last):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2525, in get_loc
    return self._engine.get_loc(key)
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: ('instance_id', '_id')

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<pyshell#97>", line 1, in <module>
    user_events=df['instance_id','_id']
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2139, in __getitem__
    return self._getitem_column(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2146, in _getitem_column
    return self._get_item_cache(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 1842, in _get_item_cache
    values = self._data.get(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\internals.py", line 3843, in get
    loc = self.items.get_loc(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2527, in get_loc
    return self._engine.get_loc(self._maybe_cast_indexer(key))
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: ('instance_id', '_id')
>>> user_events=df['instance_id' '_id']
Traceback (most recent call last):
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2525, in get_loc
    return self._engine.get_loc(key)
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: 'instance_id_id'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<pyshell#98>", line 1, in <module>
    user_events=df['instance_id' '_id']
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2139, in __getitem__
    return self._getitem_column(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2146, in _getitem_column
    return self._get_item_cache(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\generic.py", line 1842, in _get_item_cache
    values = self._data.get(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\internals.py", line 3843, in get
    loc = self.items.get_loc(item)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexes\base.py", line 2527, in get_loc
    return self._engine.get_loc(self._maybe_cast_indexer(key))
  File "pandas\_libs\index.pyx", line 117, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\index.pyx", line 139, in pandas._libs.index.IndexEngine.get_loc
  File "pandas\_libs\hashtable_class_helper.pxi", line 1265, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas\_libs\hashtable_class_helper.pxi", line 1273, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: 'instance_id_id'
>>> user_events=df[['instance_id','_id']].copy()
>>> user_events
                          instance_id                       _id
0    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322ad
1    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322ae
2    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322ae
3    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322af
4    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b0
5    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b0
6    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b0
7    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b1
8    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
9    000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
10   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
11   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
12   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
13   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
14   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
15   000bff55caf956a6255365a5acca48f2  5a6c7ef1fd2cc626d90322b2
16   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d9001159
17   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115a
18   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115a
19   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115a
20   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115a
21   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115a
22   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115b
23   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115b
24   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115c
25   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115c
26   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115c
27   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115d
28   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115d
29   001d7324e01e1e8e063fa976c2fabc25  5a6c7e22fd2cc626d900115d
..                                ...                       ...
72   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe559
73   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe559
74   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55a
75   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55a
76   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55a
77   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55a
78   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55c
79   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55c
80   00225f1f30f3584e9600364280825ba6  5a6c7e18fd2cc626d9ffe55c
81   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e1
82   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e1
83   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e1
84   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e1
85   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e1
86   00225f1f30f3584e9600364280825ba6  5a6c7e42fd2cc626d90083e2
87   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b5f
88   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b5f
89   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b60
90   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b60
91   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b60
92   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b60
93   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b61
94   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b62
95   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b62
96   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b62
97   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b63
98   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b64
99   01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b64
100  01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b64
101  01096799fcc6780dd275c71e6c6e1571  5a6c7e44fd2cc626d9008b64

[102 rows x 2 columns]
>>> use_events=df[['instance_id','_id','userid','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']].copy()
Traceback (most recent call last):
  File "<pyshell#101>", line 1, in <module>
    use_events=df[['instance_id','_id','userid','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']].copy()
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2133, in __getitem__
    return self._getitem_array(key)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\frame.py", line 2177, in _getitem_array
    indexer = self.loc._convert_to_indexer(key, axis=1)
  File "C:\Users\Harsha\AppData\Local\Programs\Python\Python36-32\lib\site-packages\pandas\core\indexing.py", line 1269, in _convert_to_indexer
    .format(mask=objarr[mask]))
KeyError: "['userid'] not in index"
>>> df.dtypes
campaign                       object
medium                         object
instance_id                    object
kns__screen_class              object
kns_lid                        object
kns__conversion                object
name                           object
userId                        float64
_id                            object
kns__event_origin              object
source                         object
kns__previous_class            object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> use_events=df[['instance_id','_id','userId','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']].copy()
>>> use_events=df[['instance_id','_id','userId','kns_lid','name','kns__screen_class','kns__previous_class','campaign','medium','source','kns__conversion','kns__event_origin','datetime_stamp','date_stamp']].copy()
>>> use_events.dtypes
instance_id                    object
_id                            object
userId                        float64
kns_lid                        object
name                           object
kns__screen_class              object
kns__previous_class            object
campaign                       object
medium                         object
source                         object
kns__conversion                object
kns__event_origin              object
datetime_stamp         datetime64[ns]
date_stamp             datetime64[ns]
dtype: object
>>> 
