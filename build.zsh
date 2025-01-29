echo "[build.zsh] deleting existing dist folder"
rm -rf ./dist
mkdir ./dist

LOFI_LESS_INDEX=src/index.less
LOFI_CSS_OUTPUT=dist/css/lofi-themes.css
LOFI_LIT_OUTPUT=dist/lit/lofi-themes.ts

mkdir -p dist/css
mkdir -p dist/lit

# compiles the CSS file
echo "[build.zsh] compiling .less to .css with lessc"
npx lessc $LOFI_LESS_INDEX $LOFI_CSS_OUTPUT

# embeds the contents of the css file inside a call to the lit css wrapper
echo "[build.zsh] embedding css in lit .ts file"
printf 'import { css } from "lit";\n\nexport default css`\n' > "$LOFI_LIT_OUTPUT" &&
cat "$LOFI_CSS_OUTPUT" >> "$LOFI_LIT_OUTPUT" &&
printf '`;\n' >> "$LOFI_LIT_OUTPUT";
echo "[build.zsh] done"
