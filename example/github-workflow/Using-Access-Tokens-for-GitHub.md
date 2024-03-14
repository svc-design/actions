使用访问令牌进行GitHub操作
在GitHub Actions中，使用访问令牌比直接使用用户名和密码更安全，因为访问令牌具有更少的权限。您可以在GitHub的Settings > Developer settings > Personal access tokens中生成新的访问令牌。

使用方法
生成访问令牌

在GitHub中导航到Settings > Developer settings > Personal access tokens页面。
点击"Generate new token"按钮。
给访问令牌起一个描述性的名称，选择所需的权限，并点击"Generate token"按钮。
复制生成的访问令牌，并将其保存在安全的地方。
在GitHub Actions中使用访问令牌

在GitHub Actions的工作流程中，您可以通过将访问令牌存储在仓库的Secrets中，并使用${{ secrets.GITHUB_TOKEN }}来访问它，从而使用访问令牌进行身份验证。
