#!/usr/bin/python
import sys
import os
import markdown
dirname = os.path.dirname(__file__)

def getValue(key,meta):
    if key in meta and len(meta[key]) > 0:
        return meta[key][0]
    else:
        return None
def mdToHtml(fileName):
    content = open(fileName).read().decode("utf-8")
    tplName = os.path.join(dirname,"md.tpl")
    tplContent = open(tplName).read().decode("utf-8")
    md = markdown.Markdown(extensions = ['markdown.extensions.meta'],output_format="html5")
    html = md.convert(content)

    title = getValue(u'title', md.Meta)
    if not title:
        title = os.path.split(fileName)[1]
        title = os.path.splitext(title)[0]
    bodyWidth = getValue(u'bodywidth', md.Meta) or u"45em"
    output = tplContent
    output = output.replace("{TITLE}",title)
    output = output.replace("{BODY_WIDTH}",bodyWidth)
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
