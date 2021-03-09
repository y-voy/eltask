# README

モデル名、カラム名、データ型を以下に記載
---
**Task**

* task_id : _integer_
* name : _string_
* description : _text_
* deadline : _datetime_
* priority : _string_
* status : _string_

**User**

* user_id : _integer_
* name : _string_
* email : _string_
* password_digest : _string_

**Label**

* label_id : _integer_
* name : _string_

**Relation**

* task_id(FK) : _integer_
* label_id(FK) : _integer_

デプロイ手順
---
1. アセットプリコンパイルを実行`rails assets:precompile RAILS_ENV=production`
2. コミットを実行`git add -A; git commit -m "init"`
3. herokuに新しいアプリケーションを作成`heroku create`
4. herokuのstackを変更`heroku stack:set heroku-18`
5. heroku buildpackを追加`heroku buildpacks:set heroku/ruby; heroku buildpacks:add --index 1 heroku/nodejs`
6. herokuにデプロイ`git push heroku master`
7. herokuでマイグレーションを実行`heroku run rails db:migrate`
8. 以降、更新時は1,2,6の順番でherokuにデプロイしていくが、heroku上でgithub連携をしている場合は、`git push`でherokuも自動連携される 
