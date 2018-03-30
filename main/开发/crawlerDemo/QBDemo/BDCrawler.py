import urllib.request
import urllib.error
import urllib.parse
import re
import string
from ParseTool import ParseTool

class BDCrawler:

    #初始化
    def __init__(self,baseURL,seeLZ):
        self.baseURL = baseURL
        self.seeLZ = '?see_lz=' + str(seeLZ)
        self.user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
        self.headers = {'User-Agent': self.user_agent}
        self.tool = ParseTool()
        # 全局file变量，文件写入操作对象
        self.file = None

    def getPage(self,pageNum):
        try:
            url = self.baseURL + self.seeLZ + '&pn=' + str(pageNum)
            request = urllib.request.Request(url,headers=self.headers)
            response = urllib.request.urlopen(request)
            #print (response.read().decode('utf-8'))
            return response.read().decode('utf-8')
        except urllib.error.URLError as e:
            if hasattr(e, "code"):
                print(e.code)
            if hasattr(e, "reason"):
                print(e.reason)
            return None

    def getPageTitle(self):
        content = self.getPage(1)
        pattern = re.compile('<h3 class="core_title_txt.*?>(.*?)</h3>',re.S)
        result = re.search(pattern,content)
        if result:
            print(result.group(1))
            return result.group(1).strip()
        else:
            return None
    def getPageNum(self):
        content = self.getPage(1)

        pattern = re.compile('<li class="l_reply_num.*?</span>.*?<span.*?>(.*?)</span>',re.S)
        result = re.search(pattern,content)
        print(content)
        if result:
            print(result.group(1))
            return result.group(1).strip()
        else:
            return None
    def getContent(self,page):
        content = self.getPage(page)
        pattern = re.compile('<div class="d_post_content_main.*?<div class="p_content.*?</div>.*?<cc>.*?<div.*?>(.*?)</div>.*?</cc>.*?<span>(.*?)</span>.*?</div>')
        items = re.findall(pattern,content)
        return items

    def setFileTitle(self,title):
        # 如果标题不是为None，即成功获取到标题
        if title is not None:
            self.file = open(title + ".txt","w+")
        else:
            self.file = open("default.txt","w+")

    def writeData(self,items):

        for item in items:
            print(item[0])
            self.file.write(u"floor:-----------\n")
            #self.file.write(item[0].strip())


    def start(self):
        self.setFileTitle("BD_file")
        try:
            items = self.getContent(1)
            self.writeData(items)
        except IOError as e:
            print("input error" + e.message)

        finally:
            print("write successfully")

baseURL = 'https://tieba.baidu.com/p/543987011'
bd = BDCrawler(baseURL,1)
#bd.getPageTitle()
bd.start()