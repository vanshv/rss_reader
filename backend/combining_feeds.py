import feedparser

first = 'https://rss.art19.com/apology-line'
all = feedparser.parse(first)

b = 'https://www.feedforall.com/sample-feed.xml'
d = 'https://www.feedforall.com/sample.xml'

c = 'https://feeds.fireside.fm/bibleinayear/rss'
g = 'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss'
h = 'https://feeds.simplecast.com/54nAGcIl'

e = [b, d, c, g, h]
f = []

def retdate(item):
    return item['published_parsed'];

for item in e:
    f.append(feedparser.parse(item))
#create list of rssfeeds


for rssfeed in f:
    for item in rssfeed.entries:
        all.entries.append(item)
#all entries of all rss feeds into a single rss feed
    
all.entries.sort(key=retdate)
#sort it according to published date

for item in all.entries:
    print(item.published)