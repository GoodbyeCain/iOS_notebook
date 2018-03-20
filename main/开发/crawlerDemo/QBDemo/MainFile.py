import urllib.request
import urllib.error
import urllib.parse
import re

user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
headers = { 'User-Agent' : user_agent}

page = 2
url = 'https://www.qiushibaike.com/hot/page/' + str(page) + '/'

try:
    request = urllib.request.Request(url,headers = headers)
    response = urllib.request.urlopen(request)
    content = response.read().decode('utf-8')

    pattern = re.compile('<div class=.*?article block.*?<div class="author clearfix">.*?<a.*?<h2.*?>(.*?)</h2>.*?class="content">.*?<span>(.*?)</span>.*?<!-- .*? -->(.*?)<div class="stats">.*?class="number">(.*?)</i>',re.S)
    items = re.findall(pattern,content)
    print(items)
    for item in items:
        hasImg = re.search("img",item[2])
        if not hasImg:
            print(item[0],item[1],item[3])

except urllib.error.URLError as e:
    if hasattr(e,"code"):
        print(e.code)
    if hasattr(e,"reason"):
        print(e.reason)