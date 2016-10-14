class ArticleSerializer
  def self.serialize(article)
    serialized_article = '{'
    serialized_article += '"id": ' + article.id.to_s + ', '
    serialized_article += '"title": "' + article.title + '", '
    serialized_article += '"author": {'
    serialized_article += '"name": "' + article.author.name + '"}' + ', '
    serialized_article += '"topic": {'
    serialized_article += '"name": "' + article.topic.name + '"}'
    serialized_article += '}'
  end
end