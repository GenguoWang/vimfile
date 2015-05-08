#!/usr/bin/python
import sys
import os
import markdown
dirname = os.path.dirname(__file__)

def mdToHtml(fileName):
    content = open(fileName).read().decode("utf-8")
    tplName = os.path.join(dirname,"md.tpl")
    tplContent = open(tplName).read().decode("utf-8")
    html = markdown.markdown(content,output_format="html5")
    title = os.path.split(fileName)[1]
    title = os.path.splitext(title)[0]
    output = tplContent
    output = output.replace("{TITLE}",title)
    output = output.replace("{CONTENT}",html)
    return output

def main():
    if len(sys.argv) > 1:
        html = mdToHtml(sys.argv[1])
        print html.encode("utf-8")
    else:
        pass
if __name__ == "__main__":
    main()
