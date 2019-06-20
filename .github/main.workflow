on: push
jobs:
  build:
    runs-on:
      pool: ${{ matrix.operating-system }}
    strategy:
      matrix:
        operating-system: [Linux, macOS, Windows]
    actions:
    - name: Set Node.js 10.x
      uses: bryanmacfarlane/node-config@master
      with:
        version: 10.x

      # Explicitly uninstall husky so that we avoid issues with git hooks/node versioning.
      # Should switch to clean checkout instead when supported.
      run: npm prune --production
      run: npm install
      run: npm uninstall husky

    - name: Lint
      run: npm run format-check

    - name: npm test
      run: npm test
