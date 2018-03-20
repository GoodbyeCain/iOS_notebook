
#:本文为糗事百科爬虫demo，主页地址：https://cuiqingcai.com/990.html

import urllib.request
import urllib.error
import urllib.parse
import re

class QBCrawler:
    # 初始化方法，定义一些变量
    def __init__(self):
        self.pageIndex = 1
        self.user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
        self.headers = {'User-Agent':self.user_agent}
        self.stories = []
        self.enable = False
    #传入某一页的索引获得页面代码
    def getPage(self,pageIndex):
        try:
            url = 'https://www.qiushibaike.com/hot/page/' + str(pageIndex)
            request = urllib.request.Request(url, headers=self.headers)
            response = urllib.request.urlopen(request)
            content = response.read().decode('utf-8')
            return content
        except urllib.error.URLError as e:
            if hasattr(e, "code"):
                print(e.code)
            if hasattr(e, "reason"):
                print(e.reason)
            return None

    # 传入某一页代码，返回本页不带图片的段子列表
    def getPageItems(self,pageIndex):
        content = self.getPage(pageIndex)
        if not content:
            return None
        pattern = re.compile(
            '<div class=.*?article block.*?<div class="author clearfix">.*?<a.*?<h2.*?>(.*?)</h2>.*?class="content">.*?<span>(.*?)</span>.*?<!-- .*? -->(.*?)<div class="stats">.*?class="number">(.*?)</i>',
            re.S)
        items = re.findall(pattern, content)
        pageStories = []
        for item in items:
            hasImg = re.search("img", item[2])
            if not hasImg:
                replaceBR = re.compile('<br/>')
                text = re.sub(replaceBR,'\n',item[1])
                pageStories.append([item[0].strip(),text.strip(),item[3].strip()])
        return pageStories

    # 加载并提取页面的内容，加入到列表中
    def loadPage(self):
        if self.enable == True:
            if len(self.stories) < 2:
                pageStories = self.getPageItems(self.pageIndex)
                if pageStories:
                    self.stories.append(pageStories)
                    self.pageIndex += 1

    # 调用该方法，每次敲回车打印输出一个段子
    def getOneStory(self,pageStories,page):
        for story in pageStories:
            # 等待用户输入
            str = input('please input:')
            # 每当输入回车一次，判断一下是否要加载新页面
            self.loadPage()
            if str == "Q":
                self.enable = False
                return
            print("第%d页\t发布人：%s\t评论人数:%s\n%s" % (page,story[0],story[2],story[1]))

    #开始方法
    def start(self):
        print("get data---Q:退出")
        self.enable = True
        self.pageIndex = 1
        self.loadPage()
        nowPage = 0
        while self.enable:
            if len(self.stories) > 0:
                pageStories = self.stories[0]
                nowPage +=1
                del self.stories[0]
                self.getOneStory(pageStories,nowPage)

spider = QBCrawler()
spider.start()


