# proto
存储用于自动生成go代码的Protobuf定义文件

```shell
#生成api模板，为防止代码被修改，一般情况下，我们会生成到一个临时目录
goctl api go -api website.api -dir ./temp
#生成grpc模板
goctl rpc protoc --go_out=. --go-grpc_out=. --zrpc_out=. ./etcd/service.proto

#如果需要生成的方法在一个文件里，则使用
# 安装插件
go install github.com/zeromicro/goctl-go-compact@latest
go install github.com/zeromicro/goctl-go-compact@v1.1.1
# 使用（替换原来的 goctl api go）
goctl-go-compact api go -api user.api -dir .
```

