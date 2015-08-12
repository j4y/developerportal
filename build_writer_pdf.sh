jekyll serve --config_base.yml,config_writer.yml,config config_writer_pdf.yml&
sleep 9

prince --input-list=../documentation-theme-jekyll-builds/writer-pdf/prince-file-list.txt -o ../documentation-theme-jekyll-builds/pdf-output/writer.pdf

kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')