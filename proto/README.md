# proto
存储用于自动生成go代码的Protobuf定义文件

```shell
#生成api模板，为防止代码被修改，一般情况下，我们会生成到一个临时目录
goctl api go -api website.api -dir ./temp
#生成grpc模板
goctl rpc protoc --go_out=./temp --go-grpc_out=./temp --zrpc_out=./temp ./rpc/user.proto --multiple
#注意
1. 生成后，将rpchandles的内容放到项目根目录。
2. config和svc的内容可以不要，我们使用架构的svc和config。
3. logic也可以不要，我们要在根目录建立自己的逻辑块，以让rest和rpcsever使用同一套具体实现。
4. etc内的配置，我们也使用架构的，如果需要增加配置项，让内核维护人员添加。

#如果需要生成的方法在一个文件里，则使用
# 安装插件
go install github.com/zeromicro/goctl-go-compact@latest
go install github.com/zeromicro/goctl-go-compact@v1.1.1
# 使用（替换原来的 goctl api go）
goctl-go-compact api go -api user.api -dir .
```

