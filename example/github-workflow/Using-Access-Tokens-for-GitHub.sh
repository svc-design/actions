- name: Clone gitops repository
  run: git clone https://github.com/svc-design/gitops.git
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

- name: Modify helm_files/app-frontend.yaml
  run: |
    sed -i 's/image.tag\r      value: ""/image.tag\r      value: "$BUILD_TAG"/' gitops/helm_files/app-frontend.yaml

- name: Commit changes
  run: |
    cd gitops
    git config user.email "you@example.com"
    git config user.name "Your Name"
    git add .
    git commit -a -m "update version -> ${{ github.sha }}"
    git push
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
