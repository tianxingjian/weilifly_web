Types.VARCHAR, false);
			public Field isShow = new Field(this, "`isShow`", Types.INTEGER, false);
			
			public t_product_category() {
				name = "`t_product_category`";
			}
		}

		public class t_product_detail extends Table {
			public Field id = new Field(this, "`id`", Types.BIGINT, true);
			public Field _name = new Field(this, "`name`", Types.VARCHAR, false);
			public Field productId = new Field(this, "`productId`", Types.BIGINT, false);
			public Field content = new Field(this, "`content`", Types.VARCHAR, false);
			public Field introduction = new Field(this, "`introduction`", Types.VARCHAR, false);
			public Field image = new Field(this, "`image`", Types.VARCHAR, false);
			public Field images = new Field(this, "`images`", Types.VARCHAR, false);
			public Field parentId = new Field(this, "`parentId`", Types.BIGINT, false);
			public Field type = new Field(this, "`type`", Types.INTEGER, false);
			public Field sortIndex = new Field(this, "`sortIndex`", Types.INTEGER, false);
			public Field status = new Field(this, "`status`", Types.INTEGER, false);
			public Field backImage = new Field(this, "`backImage`", Types.VARCHAR, false);
			
			public t_product_detail() {
				name = "`t_product_detail`";
			}
		}
		
		public class t_product_parameter extends Table {
			public Field id = new Field(this, "`id`", Types.BIGINT, true);
			public Field productId = new Field(this, "`productId`", Types.BIGINT, false);
			public Field parameterId = new Field(this, "`parameterId`", Types.BIGINT, false);
			public Field content = new Field(this, "`content`", Types.VARCHAR, false);

			public t_product_parameter() {
				name = "`t_product_parameter`";
			}
		}
		
		public class t_question_list extends Table {
			public Field id = new Field(this, "`id`", Types.BIGINT, true);
			public 