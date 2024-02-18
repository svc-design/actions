// 定义一个方法，用于执行构建操作
def build() {
    sh 'mvn clean package'
}

// 定义一个方法，用于执行测试
def test() {
    sh 'mvn test'
}

// 定义一个方法，用于执行部署
def deploy(String env) {
    echo "Deploying to ${env} environment"
    // 实现部署逻辑，这里只是一个示例
}

// 其他操作，如release, upgrade, backup, rollback, destroy等，也可以在这里定义相应的方法
def release(String env) {
    echo "Releasing version in ${env} environment"
    // 实现发布逻辑
}

