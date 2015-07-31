# reduce-cocotile-2015-07
[tentative] hadoop-streaming reducer for creating [cocotile](https://github.com/gsi-cyberjapan/cocotile-spec)

## What is this?
hadoop-streaming reducer for creating cocotile from a list of slippy map tilename and tile id as follows:

```
...
13/6987/3489	std
13/6987/3490	std
13/6987/3491	std
13/6987/3492	std
13/6987/3493	std
13/6987/3494	std
13/6987/3495	std
13/6987/3496	std
13/6987/3497	std
13/6987/3498	std
13/6987/3499	std
13/6987/3500	std
13/6987/3501	std
13/6987/3502	std
...
```
where 'std' is the tile id.

## Usage
Put your input as above in input directory and run hadoop-streaming as follows:
```
hadoop jar /usr/local/Cellar/hadoop/2.6.0/libexec/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar -input input -output output -mapper cat -reducer reduce.rb
```
as written in [reduce.rb](reduce.rb).

This program is used for generating cocotile from a bunch of mokuroku.csv.gz on 2015-07-31.

## TODO
- The whole process, including downloading a bunch of mokuroku.csv.gz using layers*.txt, generating the list of tile id as above, and then running hadoop-streaming, must be integrated in future.
- The format of the output might better be a bunch of text files similar to serialtiles, not the cocotile directory itself, to ease the output and the transport of the cocotile tileset faster.

## ChangeLog

- 2015-07-31 Release
