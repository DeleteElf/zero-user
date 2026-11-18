/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2026/11/18 16:50:16                          */
/*==============================================================*/


/*==============================================================*/
/* Table: T_DEPARTMENT_INFO                                     */
/*==============================================================*/
CREATE TABLE T_DEPARTMENT_INFO (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_PARENT_ID          INT8                 NOT NULL,
   F_CODE               VARCHAR(20)          NULL,
   F_OUT_CODE           VARCHAR(50)          NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_DEPARTMENT_INFO PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_DEPARTMENT_INFO IS
'部门信息表';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_ID IS
'编号';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_SERVICE_ID IS
'服务编号';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_NAME IS
'名称';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_PARENT_ID IS
'上级部门';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_CODE IS
'部门编码';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_OUT_CODE IS
'外部编码';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_DEPARTMENT_INFO.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_DEPARTMENT_INFO                                 */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_DEPARTMENT_INFO ON T_DEPARTMENT_INFO (
F_NAME,
F_PARENT_ID
);

/*==============================================================*/
/* Table: T_DEPARTMENT_USER                                     */
/*==============================================================*/
CREATE TABLE T_DEPARTMENT_USER (
   F_ID                 SERIAL NOT NULL,
   F_DEPARTMENT_ID      INT8                 NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_DEPARTMENT_USER PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_DEPARTMENT_USER IS
'部门用户关系表';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_ID IS
'编号';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_DEPARTMENT_ID IS
'部门编号';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_DEPARTMENT_USER.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_DEPARTMENT_USER                                     */
/*==============================================================*/
CREATE UNIQUE INDEX U_DEPARTMENT_USER ON T_DEPARTMENT_USER (
F_USER_ID,
F_DEPARTMENT_ID
);

/*==============================================================*/
/* Table: T_FUNCTION_INFO                                       */
/*==============================================================*/
CREATE TABLE T_FUNCTION_INFO (
   F_ID                 SERIAL NOT NULL,
   F_NAME               VARCHAR(20)          NOT NULL,
   F_AUTHORIZE_CODE     VARCHAR(50)          NOT NULL,
   F_PARENT_ID          INT8                 NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_FUNCTION_INFO PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_FUNCTION_INFO IS
'功能表';

COMMENT ON COLUMN T_FUNCTION_INFO.F_ID IS
'编号';

COMMENT ON COLUMN T_FUNCTION_INFO.F_NAME IS
'名称';

COMMENT ON COLUMN T_FUNCTION_INFO.F_AUTHORIZE_CODE IS
'授权编码';

COMMENT ON COLUMN T_FUNCTION_INFO.F_PARENT_ID IS
'上级权限';

COMMENT ON COLUMN T_FUNCTION_INFO.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_FUNCTION_INFO.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_FUNCTION_INFO.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_FUNCTION_INFO.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_FUNCTION_INFO.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_FUNCTION                                        */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_FUNCTION ON T_FUNCTION_INFO (
F_AUTHORIZE_CODE
);

/*==============================================================*/
/* Index: U_SYS_FUNCTION2                                       */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_FUNCTION2 ON T_FUNCTION_INFO (
F_NAME,
F_PARENT_ID
);

/*==============================================================*/
/* Table: T_ROLE_FUNCTION                                       */
/*==============================================================*/
CREATE TABLE T_ROLE_FUNCTION (
   F_ID                 SERIAL NOT NULL,
   F_ROLE_ID            INT8                 NOT NULL,
   F_FUNCTION_ID        INT8                 NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_ROLE_FUNCTION PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_ROLE_FUNCTION IS
'角色功能关系表';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_ID IS
'编号';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_ROLE_ID IS
'角色编号';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_FUNCTION_ID IS
'权限编号';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_ROLE_FUNCTION.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_ROLE_FUNCTION                                       */
/*==============================================================*/
CREATE UNIQUE INDEX U_ROLE_FUNCTION ON T_ROLE_FUNCTION (
F_ROLE_ID,
F_FUNCTION_ID
);

/*==============================================================*/
/* Table: T_ROLE_INFO                                           */
/*==============================================================*/
CREATE TABLE T_ROLE_INFO (
   F_ID                 SERIAL NOT NULL,
   F_NAME               VARCHAR(20)          NOT NULL,
   F_PARENT_ID          INT8                 NOT NULL DEFAULT 0,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_ROLE_INFO PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_ROLE_INFO IS
'角色信息表';

COMMENT ON COLUMN T_ROLE_INFO.F_ID IS
'编号';

COMMENT ON COLUMN T_ROLE_INFO.F_NAME IS
'名称';

COMMENT ON COLUMN T_ROLE_INFO.F_PARENT_ID IS
'上级角色';

COMMENT ON COLUMN T_ROLE_INFO.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_ROLE_INFO.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_ROLE_INFO.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_ROLE_INFO.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_ROLE_INFO.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_ROLE_INFO                                       */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_ROLE_INFO ON T_ROLE_INFO (
F_NAME,
F_PARENT_ID
);

/*==============================================================*/
/* Table: T_SERVICE_OBJECT                                      */
/*==============================================================*/
CREATE TABLE T_SERVICE_OBJECT (
   F_ID                 SERIAL NOT NULL,
   F_APP_ID             VARCHAR(50)          NULL,
   F_PARENT_ID          INT8                 NOT NULL DEFAULT 0,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_APP_NAME           VARCHAR(50)          NULL,
   F_SHORT_NAME         VARCHAR(4)           NOT NULL,
   F_TAX_ID             VARCHAR(18)          NULL,
   F_BANK_ID            VARCHAR(18)          NULL,
   F_MOENY              DECIMAL(10,2)        NOT NULL DEFAULT 0,
   F_REPRESENTATIVE     VARCHAR(18)          NULL,
   F_TELPHONE           VARCHAR(18)          NULL,
   F_HOST_PORT          VARCHAR(100)         NULL,
   F_ACCESS_KEY         VARCHAR(200)         NULL,
   F_EXPIRE_TIME        TIMESTAMP            NULL,
   F_TYPE               INT2                 NOT NULL DEFAULT 0,
   F_MODE               INT2                 NULL,
   F_ADMIN_ACCOUNT      VARCHAR(50)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SERVICE_OBJECT PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_OBJECT IS
'服务实体对象';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_ID IS
'编号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_APP_ID IS
'App编号,通过RSA加密获取，并保存，前端通过APPID来识别自己的属于哪个app';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_PARENT_ID IS
'父服务实体编号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_NAME IS
'名称';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_APP_NAME IS
'系统名称';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_SHORT_NAME IS
'短名称';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_TAX_ID IS
'纳税识别号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_BANK_ID IS
'银行账号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_MOENY IS
'余额';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_REPRESENTATIVE IS
'法人代表';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_TELPHONE IS
'联系电话';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_HOST_PORT IS
'主机地址';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_ACCESS_KEY IS
'加密狗KEY';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_EXPIRE_TIME IS
'服务到期时间';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_TYPE IS
'服务类型，默认服务类型0，如果服务类型为1，提供unionid支持';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_MODE IS
'服务模式，服务的收费模式';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_ADMIN_ACCOUNT IS
'管理员账号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_OBJECT.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_SERVICE                                         */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_SERVICE ON T_SERVICE_OBJECT (
F_NAME
);

/*==============================================================*/
/* Index: U_SYS_SERVICE2                                        */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_SERVICE2 ON T_SERVICE_OBJECT (
F_TAX_ID
);

/*==============================================================*/
/* Table: T_SERVICE_SETTING                                     */
/*==============================================================*/
CREATE TABLE T_SERVICE_SETTING (
   F_ID                 SERIAL NOT NULL,
   F_SETTING_ID         INT8                 NOT NULL DEFAULT 1,
   F_CODE               VARCHAR(50)          NULL,
   F_NAME               VARCHAR(50)          NULL,
   F_VALUE              VARCHAR(50)          NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SERVICE_SETTING PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_SETTING IS
'服务配置明细';

COMMENT ON COLUMN T_SERVICE_SETTING.F_ID IS
'自动编号';

COMMENT ON COLUMN T_SERVICE_SETTING.F_SETTING_ID IS
'公司id';

COMMENT ON COLUMN T_SERVICE_SETTING.F_CODE IS
'公用令牌';

COMMENT ON COLUMN T_SERVICE_SETTING.F_NAME IS
'参数名称';

COMMENT ON COLUMN T_SERVICE_SETTING.F_VALUE IS
'参数值';

COMMENT ON COLUMN T_SERVICE_SETTING.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_SETTING.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_SETTING.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_SETTING.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_SETTING.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_SERVICE_SETTING                                 */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_SERVICE_SETTING ON T_SERVICE_SETTING (
F_CODE
);

/*==============================================================*/
/* Table: T_SERVICE_USER                                        */
/*==============================================================*/
CREATE TABLE T_SERVICE_USER (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL DEFAULT 1,
   F_USER_ID            INT8                 NOT NULL,
   F_OPEN_ID            VARCHAR(50)          NULL,
   F_ADMIN_ACCOUNT      BOOL                 NOT NULL DEFAULT FALSE,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SERVICE_USER PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_USER IS
'用户服务实体关系表';

COMMENT ON COLUMN T_SERVICE_USER.F_ID IS
'编号';

COMMENT ON COLUMN T_SERVICE_USER.F_SERVICE_ID IS
'服务编号';

COMMENT ON COLUMN T_SERVICE_USER.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_SERVICE_USER.F_OPEN_ID IS
'开放标识';

COMMENT ON COLUMN T_SERVICE_USER.F_ADMIN_ACCOUNT IS
'是否管理账号';

COMMENT ON COLUMN T_SERVICE_USER.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_USER.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_USER.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_USER.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_USER.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SERVICE_USER                                        */
/*==============================================================*/
CREATE UNIQUE INDEX U_SERVICE_USER ON T_SERVICE_USER (
F_SERVICE_ID,
F_USER_ID
);

/*==============================================================*/
/* Table: T_SERVICE_ADDRESS                                     */
/*==============================================================*/
CREATE TABLE T_SERVICE_ADDRESS (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL DEFAULT 0,
   F_HOST_PORT          VARCHAR(100)         NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SERVICE_ADDRESS PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_ADDRESS IS
'白名单地址列表';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_ID IS
'编号';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_SERVICE_ID IS
'服务实体编号';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_HOST_PORT IS
'主机地址';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_ADDRESS.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_SERVICE_ADDRESS                                 */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_SERVICE_ADDRESS ON T_SERVICE_ADDRESS (
F_HOST_PORT
);

/*==============================================================*/
/* Table: T_SERVICE_DEPARTMENT                                  */
/*==============================================================*/
CREATE TABLE T_SERVICE_DEPARTMENT (
   F_ID                 SERIAL               NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             VARCHAR(50)          NULL,
   CONSTRAINT PK_T_SERVICE_DEPARTMENT PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_DEPARTMENT IS
'部门服务实体关系表';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_ID IS
'自动编号';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_DEPARTMENT.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_SERVICE_LIST                                        */
/*==============================================================*/
CREATE TABLE T_SERVICE_LIST (
   F_ID                 SERIAL NOT NULL,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_TYPE               INT2                 NOT NULL DEFAULT 0,
   F_SERVICE_ID         INT8                 NULL,
   F_USER_ID            INT8                 NULL,
   F_EXPIRE_TIME        TIMESTAMP            NULL,
   F_HANDLE_RIGHT       VARCHAR(18)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SERVICE_LIST PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SERVICE_LIST IS
'服务清单';

COMMENT ON COLUMN T_SERVICE_LIST.F_ID IS
'编号';

COMMENT ON COLUMN T_SERVICE_LIST.F_NAME IS
'名称';

COMMENT ON COLUMN T_SERVICE_LIST.F_TYPE IS
'服务类型，0为B端，1为B端上级平台，2为c端用户';

COMMENT ON COLUMN T_SERVICE_LIST.F_SERVICE_ID IS
'服务对象，支持c端用户，支持b端用户';

COMMENT ON COLUMN T_SERVICE_LIST.F_USER_ID IS
'服务对象，支持c端用户，支持b端用户';

COMMENT ON COLUMN T_SERVICE_LIST.F_EXPIRE_TIME IS
'服务到期时间,为空时表示永远不会到期';

COMMENT ON COLUMN T_SERVICE_LIST.F_HANDLE_RIGHT IS
'服务授权';

COMMENT ON COLUMN T_SERVICE_LIST.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SERVICE_LIST.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SERVICE_LIST.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SERVICE_LIST.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SERVICE_LIST.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_SERVICE_LIST                                    */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_SERVICE_LIST ON T_SERVICE_LIST (
F_TYPE,
F_SERVICE_ID,
F_HANDLE_RIGHT,
F_USER_ID
);

/*==============================================================*/
/* Table: T_USER_CONFIG                                         */
/*==============================================================*/
CREATE TABLE T_USER_CONFIG (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL DEFAULT 1,
   F_USER_ID            INT8                 NOT NULL,
   F_CODE               VARCHAR(20)          NOT NULL,
   F_NAME               VARCHAR(20)          NOT NULL,
   F_VALUE              VARCHAR(20)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_CONFIG PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_CONFIG IS
'用户个人配置表';

COMMENT ON COLUMN T_USER_CONFIG.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_CONFIG.F_SERVICE_ID IS
'服务编号';

COMMENT ON COLUMN T_USER_CONFIG.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_USER_CONFIG.F_CODE IS
'编码';

COMMENT ON COLUMN T_USER_CONFIG.F_NAME IS
'名称';

COMMENT ON COLUMN T_USER_CONFIG.F_VALUE IS
'值';

COMMENT ON COLUMN T_USER_CONFIG.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_CONFIG.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_CONFIG.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_CONFIG.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_CONFIG.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_USER_CONFIG                                         */
/*==============================================================*/
CREATE UNIQUE INDEX U_USER_CONFIG ON T_USER_CONFIG (
F_USER_ID,
F_SERVICE_ID
);

/*==============================================================*/
/* Table: T_USER_INFO                                           */
/*==============================================================*/
CREATE TABLE T_USER_INFO (
   F_ID                 SERIAL NOT NULL,
   F_ACCOUNT            VARCHAR(20)          NOT NULL,
   F_PASSWORD           VARCHAR(32)          NOT NULL,
   F_NAME               VARCHAR(20)          NULL,
   F_USER_NAME          VARCHAR(100)         NULL,
   F_LAST_NAME          VARCHAR(50)          NULL,
   F_FIRST_NAME         VARCHAR(50)          NULL,
   F_CODE               VARCHAR(20)          NULL,
   F_OUT_CODE           VARCHAR(50)          NULL,
   F_OUT_NICK_NAME      VARCHAR(50)          NULL,
   F_SEX                VARCHAR(2)           NULL DEFAULT '男',
   F_EMAIL              VARCHAR(50)          NULL,
   F_EMAIL_STATE        BOOL                 NULL DEFAULT FALSE,
   F_COUNTRY_ID         INT4                 NULL,
   F_ADDRESS            VARCHAR(100)         NULL,
   F_PHONE              VARCHAR(20)          NULL,
   F_TELEPHONE          VARCHAR(20)          NULL,
   F_AVATAR             VARCHAR(255)         NULL,
   F_MEMORIAL_DAY       VARCHAR(10)          NULL,
   F_CHECKED            BOOL                 NOT NULL DEFAULT FALSE,
   F_EXPIRE_DATE        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_FAILED_COUNT       INT2                 NULL,
   F_FAILED_TIME        TIMESTAMP            NULL DEFAULT CURRENT_TIMESTAMP,
   F_FREEZE             BOOL                 NOT NULL DEFAULT FALSE,
   F_THAW_TIME          TIMESTAMP            NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_INFO PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_INFO IS
'用户信息表';

COMMENT ON COLUMN T_USER_INFO.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_INFO.F_ACCOUNT IS
'账号';

COMMENT ON COLUMN T_USER_INFO.F_PASSWORD IS
'密码';

COMMENT ON COLUMN T_USER_INFO.F_NAME IS
'昵称';

COMMENT ON COLUMN T_USER_INFO.F_USER_NAME IS
'姓名';

COMMENT ON COLUMN T_USER_INFO.F_LAST_NAME IS
'姓';

COMMENT ON COLUMN T_USER_INFO.F_FIRST_NAME IS
'名';

COMMENT ON COLUMN T_USER_INFO.F_CODE IS
'身份证号';

COMMENT ON COLUMN T_USER_INFO.F_OUT_CODE IS
'外部编码';

COMMENT ON COLUMN T_USER_INFO.F_OUT_NICK_NAME IS
'外部昵称';

COMMENT ON COLUMN T_USER_INFO.F_SEX IS
'性别';

COMMENT ON COLUMN T_USER_INFO.F_EMAIL IS
'邮箱';

COMMENT ON COLUMN T_USER_INFO.F_EMAIL_STATE IS
'邮箱状态';

COMMENT ON COLUMN T_USER_INFO.F_COUNTRY_ID IS
'国家编号';

COMMENT ON COLUMN T_USER_INFO.F_ADDRESS IS
'住址';

COMMENT ON COLUMN T_USER_INFO.F_PHONE IS
'电话';

COMMENT ON COLUMN T_USER_INFO.F_TELEPHONE IS
'手机';

COMMENT ON COLUMN T_USER_INFO.F_AVATAR IS
'头像';

COMMENT ON COLUMN T_USER_INFO.F_MEMORIAL_DAY IS
'纪念日';

COMMENT ON COLUMN T_USER_INFO.F_CHECKED IS
'是否认证';

COMMENT ON COLUMN T_USER_INFO.F_EXPIRE_DATE IS
'密码有效截止日期';

COMMENT ON COLUMN T_USER_INFO.F_FAILED_COUNT IS
'连续失败次数';

COMMENT ON COLUMN T_USER_INFO.F_FAILED_TIME IS
'最后失败时间';

COMMENT ON COLUMN T_USER_INFO.F_FREEZE IS
'是否冻结';

COMMENT ON COLUMN T_USER_INFO.F_THAW_TIME IS
'解冻时间';

COMMENT ON COLUMN T_USER_INFO.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_INFO.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_INFO.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_INFO.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_INFO.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_USER_INFO                                       */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_USER_INFO ON T_USER_INFO (
F_NAME
);

/*==============================================================*/
/* Index: U_SYS_USER_INFO2                                      */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_USER_INFO2 ON T_USER_INFO (
F_ACCOUNT
);

/*==============================================================*/
/* Table: T_USER_ROLE                                           */
/*==============================================================*/
CREATE TABLE T_USER_ROLE (
   F_ID                 SERIAL NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_ROLE_ID            INT8                 NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_ROLE PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_ROLE IS
'用户角色关系表';

COMMENT ON COLUMN T_USER_ROLE.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_ROLE.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_USER_ROLE.F_ROLE_ID IS
'角色编号';

COMMENT ON COLUMN T_USER_ROLE.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_ROLE.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_ROLE.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_ROLE.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_ROLE.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_USER_ROLE                                           */
/*==============================================================*/
CREATE UNIQUE INDEX U_USER_ROLE ON T_USER_ROLE (
F_USER_ID,
F_ROLE_ID
);

/*==============================================================*/
/* Table: T_MENU_MODULE                                         */
/*==============================================================*/
CREATE TABLE T_MENU_MODULE (
   F_ID                 SERIAL NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_MENU_ID            INT8                 NOT NULL,
   F_MODEL_NAME         VARCHAR(20)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_MENU_MODULE PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_MENU_MODULE IS
'菜单组件表';

COMMENT ON COLUMN T_MENU_MODULE.F_ID IS
'编号';

COMMENT ON COLUMN T_MENU_MODULE.F_USER_ID IS
'用户id';

COMMENT ON COLUMN T_MENU_MODULE.F_MENU_ID IS
'菜单id';

COMMENT ON COLUMN T_MENU_MODULE.F_MODEL_NAME IS
'模式名称';

COMMENT ON COLUMN T_MENU_MODULE.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_MENU_MODULE.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_MENU_MODULE.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_MENU_MODULE.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_MENU_MODULE.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_MENU_MODULE                                     */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_MENU_MODULE ON T_MENU_MODULE (
F_MENU_ID
);

/*==============================================================*/
/* Table: T_THIRD_PARTY_SERVICE                                 */
/*==============================================================*/
CREATE TABLE T_THIRD_PARTY_SERVICE (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL,
   F_CODE               VARCHAR(50)          NULL,
   F_NAME               VARCHAR(50)          NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_THIRD_PARTY_SERVICE PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_THIRD_PARTY_SERVICE IS
'第三方服务实体配置';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_ID IS
'自动编号';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_SERVICE_ID IS
'公司id';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_CODE IS
'平台编码';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_NAME IS
'公用令牌';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_THIRD_PARTY_SERVICE.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_REGION_AREA                                         */
/*==============================================================*/
CREATE TABLE T_REGION_AREA (
   F_ID                 SERIAL NOT NULL,
   F_CODE               VARCHAR(12)          NOT NULL,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_PARENT             VARCHAR(12)          NULL,
   F_CENTER             JSONB                NULL,
   F_CENTER_OID         JSONB                NULL,
   F_GEOM               GEOMETRY             NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_REGION_AREA PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_REGION_AREA IS
'系统行政区划';

COMMENT ON COLUMN T_REGION_AREA.F_ID IS
'编号';

COMMENT ON COLUMN T_REGION_AREA.F_CODE IS
'编码';

COMMENT ON COLUMN T_REGION_AREA.F_NAME IS
'名称';

COMMENT ON COLUMN T_REGION_AREA.F_PARENT IS
'父编码';

COMMENT ON COLUMN T_REGION_AREA.F_CENTER IS
'中心';

COMMENT ON COLUMN T_REGION_AREA.F_CENTER_OID IS
'中心oid';

COMMENT ON COLUMN T_REGION_AREA.F_GEOM IS
'区划面数据';

COMMENT ON COLUMN T_REGION_AREA.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_REGION_AREA.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_REGION_AREA.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_REGION_AREA.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_REGION_AREA.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_SYS_REGION_AREA                                     */
/*==============================================================*/
CREATE UNIQUE INDEX U_SYS_REGION_AREA ON T_REGION_AREA (
F_CODE
);

/*==============================================================*/
/* Table: T_USER_LEVEL                                          */
/*==============================================================*/
CREATE TABLE T_USER_LEVEL (
   F_ID                 SERIAL NOT NULL,
   F_SERVICE_ID         INT8                 NOT NULL,
   F_CODE               VARCHAR(20)          NOT NULL,
   F_LEVEL              INT2                 NOT NULL DEFAULT 0,
   F_VALUE              TEXT                 NOT NULL DEFAULT '{}',
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_LEVEL PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_LEVEL IS
'用户级别信息';

COMMENT ON COLUMN T_USER_LEVEL.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_LEVEL.F_SERVICE_ID IS
'服务编号';

COMMENT ON COLUMN T_USER_LEVEL.F_CODE IS
'编码';

COMMENT ON COLUMN T_USER_LEVEL.F_LEVEL IS
'用户级别,默认为0级，属于未定义用户级别，级别一共分为5个级别，随着数值增大，危险性增高';

COMMENT ON COLUMN T_USER_LEVEL.F_VALUE IS
'详细信息:存储json格式的数据，描述用户为什么会定义为此级别，可能是会是一些历史犯罪记录信息';

COMMENT ON COLUMN T_USER_LEVEL.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_LEVEL.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_LEVEL.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_LEVEL.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_LEVEL.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_USER_LEVEL                                          */
/*==============================================================*/
CREATE UNIQUE INDEX U_USER_LEVEL ON T_USER_LEVEL (
F_SERVICE_ID,
F_CODE
);

/*==============================================================*/
/* Table: T_USER_SESSION                                        */
/*==============================================================*/
CREATE TABLE T_USER_SESSION (
   F_ID                 SERIAL NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_DEVICE_NAME        VARCHAR(20)          NOT NULL,
   F_APP_ID             VARCHAR(20)          NOT NULL,
   F_CODE               VARCHAR(20)          NOT NULL,
   F_GEOM               GEOMETRY             NOT NULL,
   F_LANGUAGE           VARCHAR(20)          NOT NULL DEFAULT '{}',
   F_APP_VERSION        VARCHAR(255)         NOT NULL,
   F_OS_VERSION         VARCHAR(255)         NOT NULL,
   F_LAST_LOGIN_TIME    TIMESTAMP            NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_SESSION PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_SESSION IS
'用户当前会话';

COMMENT ON COLUMN T_USER_SESSION.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_SESSION.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_USER_SESSION.F_DEVICE_NAME IS
'设备信息';

COMMENT ON COLUMN T_USER_SESSION.F_APP_ID IS
'app标识';

COMMENT ON COLUMN T_USER_SESSION.F_CODE IS
'客户端IP';

COMMENT ON COLUMN T_USER_SESSION.F_GEOM IS
'位置信息';

COMMENT ON COLUMN T_USER_SESSION.F_LANGUAGE IS
'详细信息:存储json格式的数据，需要包含采集设备信息，识别率等等，有条件也可以考虑存储采样图片';

COMMENT ON COLUMN T_USER_SESSION.F_APP_VERSION IS
'app版本';

COMMENT ON COLUMN T_USER_SESSION.F_OS_VERSION IS
'os版本';

COMMENT ON COLUMN T_USER_SESSION.F_LAST_LOGIN_TIME IS
'最近上线时间';

COMMENT ON COLUMN T_USER_SESSION.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_SESSION.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_SESSION.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_SESSION.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_SESSION.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_USER_SESSION                                        */
/*==============================================================*/
CREATE UNIQUE INDEX U_USER_SESSION ON T_USER_SESSION (
F_USER_ID,
F_DEVICE_NAME,
F_APP_ID
);

/*==============================================================*/
/* Table: T_USER_SESSION_RECORD                                 */
/*==============================================================*/
CREATE TABLE T_USER_SESSION_RECORD (
   F_ID                 SERIAL NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_DEVICE_NAME        VARCHAR(20)          NOT NULL,
   F_APP_ID             VARCHAR(20)          NOT NULL,
   F_CODE               VARCHAR(20)          NOT NULL,
   F_GEOM               GEOMETRY             NOT NULL,
   F_LANGUAGE           VARCHAR(20)          NOT NULL DEFAULT '{}',
   F_APP_VERSION        VARCHAR(255)         NOT NULL,
   F_OS_VERSION         VARCHAR(255)         NOT NULL,
   F_LOGIN_TIME         TIMESTAMP            NOT NULL,
   F_OFFLINE_TIME       TIMESTAMP            NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_USER_SESSION_RECORD PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_USER_SESSION_RECORD IS
'用户会话记录';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_ID IS
'编号';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_USER_ID IS
'用户编号';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_DEVICE_NAME IS
'设备信息';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_APP_ID IS
'app标识';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_CODE IS
'客户端IP';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_GEOM IS
'位置信息';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_LANGUAGE IS
'详细信息:存储json格式的数据，需要包含采集设备信息，识别率等等，有条件也可以考虑存储采样图片';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_APP_VERSION IS
'app版本';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_OS_VERSION IS
'os版本';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_LOGIN_TIME IS
'最近上线时间';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_OFFLINE_TIME IS
'下线时间';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_USER_SESSION_RECORD.F_REMARK IS
'备注';

