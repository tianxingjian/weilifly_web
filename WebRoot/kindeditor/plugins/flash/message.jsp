= new Field(this, "`regionType`", Types.INTEGER, false);

			public t_region() {
				name = "`t_region`";
			}
		}
		
		public class t_report extends Table {
			public Field id = new Field(this, "`id`", Types.BIGINT, true);
			public Field categoryId = new Field(this, "`categoryId`", Types.BIGINT, false);
			public Field title = new Field(this, "`title`", Types.VARCHAR, false);
			public Field author = new Field(this, "`author`", Types.VARCHAR, false);
			public Field image = new Field(this, "`image`", Types.VARCHAR, false);
			public Field addTime = new Field(this, "`addTime`", Types.TIMESTAMP, false);
			public Field path = new Field(this, "`path`", Types.VARCHAR, false);
			public Field status = new Field(this, "`status`", Types.INTEGER, false);
			public Field sortIndex = new Field(this, "`sortIndex`", Types.INTEGER, false);
			public Field seoTitle = new Field(this, "`seoTitle`", Types.VARCHAR, false);
			public Field seoKeywords = new Field(this, "`seoKeywords`", Types.VARCHAR, false);
			public Fi