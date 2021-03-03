# README

モデル名、カラム名、データ型を以下に記載

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
