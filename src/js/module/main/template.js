define([], function() {return {"page":Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "\n\n<div class=\"left\">\n    <div class=\"container\">\n        <div class=\"avatar\"></div>\n        <div class=\"nick\">简时文书</div>\n        <ul class=\"info-list\">\n            <li class=\"info-item\">\n                <span class=\"count\">4</span>\n                <span class=\"name\">文章</span>\n                <span aria-hidden=\"true\" class=\"icon icon-book-open\"></span>\n            </li>\n            <li class=\"info-item\">\n                <span class=\"count\">21</span>\n                <span class=\"name\">收藏</span>\n                <span aria-hidden=\"true\" class=\"icon icon-drawer\"></span>\n            </li>\n            <li class=\"info-item\">\n                <span class=\"count\">12</span>\n                <span class=\"name\">兴趣</span>\n                <span aria-hidden=\"true\" class=\"icon icon-badge\"></span>\n            </li>\n            <li class=\"info-item\">\n                <span class=\"count\">7</span>\n                <span class=\"name\">喜欢</span>\n                <span aria-hidden=\"true\" class=\"icon icon-heart\"></span>\n            </li>\n            <li class=\"info-item\">\n                <span class=\"count\">34</span>\n                <span class=\"name\">阅读</span>\n                <span aria-hidden=\"true\" class=\"icon icon-speech\"></span>\n            </li>\n            <li class=\"info-item\">\n                <span class=\"count\">1433</span>\n                <span class=\"name\">文字</span>\n                <span aria-hidden=\"true\" class=\"icon icon-list\"></span>\n            </li>\n        </ul>\n        <div class=\"write\"><span aria-hidden=\"true\" class=\"icon icon-book-open\"></span>续写文章</div>\n        <!-- <ul class=\"menu\">\n            <li class=\"menu-item\">\n                <span aria-hidden=\"true\" class=\"icon icon-bubbles\"></span>\n                <span class=\"name\">关注动态</span>\n            </li>\n            <li class=\"menu-item\">\n                <span aria-hidden=\"true\" class=\"icon icon-layers\"></span>\n                <span class=\"name\">发现兴趣</span>\n            </li>\n            <li class=\"menu-item recommend\">\n                <span aria-hidden=\"true\" class=\"icon icon-badge\"></span>\n                <span class=\"name\">随机推荐</span>\n            </li>\n        </ul> -->\n    </div>\n</div>\n<div class=\"right\">\n    <!-- <div class=\"title\"><span aria-hidden=\"true\" class=\"icon icon-bubbles\"></span>发现兴趣</div> -->\n    <div class=\"logo\"></div>\n    <div class=\"tool\">\n        <div class=\"item\" data-id=\"main\">\n            <i class=\"icon-bubbles\"></i>\n            <span class=\"name\">动态</span>\n        </div>\n        <div class=\"item\">\n            <i class=\"icon-clock\"></i>\n            <span class=\"name\">草稿</span>\n            <span class=\"count\">(12)</span>\n        </div>\n        <div class=\"item\">\n            <i class=\"icon-book-open\"></i>\n            <span class=\"name\">公开</span>\n            <span class=\"count\">(34)</span>\n        </div>\n        <div class=\"item\" data-id=\"setting\">\n            <i class=\"icon-settings\"></i>\n            <span class=\"name\">设置</span>\n        </div>\n        <div class=\"item\" data-id=\"circle\">\n            <i class=\"icon-badge\"></i>\n            <span class=\"name\">兴趣</span>\n            <span class=\"count\">(34)</span>\n        </div>\n    </div>\n    <div class=\"main\"></div>\n</div>\n\n";
  }),
"articles":Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1, helper;
  buffer += "\n    <li class=\"article-item\" data-id=\"";
  if (helper = helpers.id) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.id); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n        ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.thematic), {hash:{},inverse:self.noop,fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n        <ul class=\"tool\">\n            <li class=\"view\"><i class=\"icon-book-open\"></i></li>\n            <li class=\"remove\"><i class=\"icon-trash\"></i></li>\n        </ul>\n        <div class=\"card\">\n            <div class=\"title\">";
  if (helper = helpers.title) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.title); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</div>\n            <div class=\"preview\">";
  if (helper = helpers.content) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.content); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "</div>\n            <div class=\"footer\">\n                <div class=\"author\">\n                    <div class=\"avatar\"></div>\n                    ";
  if (helper = helpers.author) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.author); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + " ";
  if (helper = helpers.time) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.time); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + " 发表于旅行\n                </div>\n                <div class=\"detail\">\n                    <span class=\"item\"><span aria-hidden=\"true\" class=\"icon icon-book-open\"></span>234</span>\n                    <span class=\"item\"><span aria-hidden=\"true\" class=\"icon icon-heart\"></span>18</span>\n                </div>\n            </div>\n        </div>\n    </li>\n    ";
  return buffer;
  }
function program2(depth0,data) {
  
  var buffer = "", stack1, helper;
  buffer += "<div class=\"thematic\" style=\"background-image: url(";
  if (helper = helpers.thematic) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.thematic); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + ");\"></div>";
  return buffer;
  }

  buffer += "\n\n<ul class=\"article-list\">\n    ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.articles), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</ul>\n\n";
  return buffer;
  }),
"cirles":Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "\n\n<ul class=\"circle-list\">\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-film\"></span>\n            <div class=\"name\">电影</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-music-tone-alt\"></span>\n            <div class=\"name\">音乐</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-ghost\"></span>\n            <div class=\"name\">动漫</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-camera\"></span>\n            <div class=\"name\">摄影</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-pointer\"></span>\n            <div class=\"name\">旅行</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-rocket\"></span>\n            <div class=\"name\">产品</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-bulb\"></span>\n            <div class=\"name\">想法</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-game-controller\"></span>\n            <div class=\"name\">游戏</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-pencil\"></span>\n            <div class=\"name\">绘画</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-screen-desktop\"></span>\n            <div class=\"name\">程序</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-eyeglasses\"></span>\n            <div class=\"name\">阅读</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-layers\"></span>\n            <div class=\"name\">设计</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-cup\"></span>\n            <div class=\"name\">美食</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n    <li class=\"circle-item\">\n        <div class=\"info\">\n            <span aria-hidden=\"true\" class=\"icon icon-handbag\"></span>\n            <div class=\"name\">生活</div>\n            <div class=\"description\">光影魅力，影评推荐</div>\n        </div>\n    </li>\n</ul>\n";
  }),
}});;