const fs = require('fs');
const path = require('path');

const projectRoot = __dirname;
const outputFile = path.join(projectRoot, 'Crime_Analysis_Full_Code.txt');

const directoriesToScan = [
    'client/src',
    'server'
];

const ignoredDirs = ['node_modules', 'dist', '.git', 'assets'];
const fileExtensions = ['.js', '.jsx', '.css', '.html', '.py', '.json'];

let fullText = `=== CRIME PATTERN ANALYSIS SYSTEM FULL SOURCE CODE ===\n\n`;

function scanDirectory(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        const stat = fs.statSync(fullPath);
        
        if (stat.isDirectory()) {
            if (!ignoredDirs.includes(file)) {
                scanDirectory(fullPath);
            }
        } else {
            const ext = path.extname(fullPath);
            if (fileExtensions.includes(ext) && file !== 'package-lock.json') {
                const relativePath = path.relative(projectRoot, fullPath);
                fullText += `\n\n======================================================\n`;
                fullText += `FILE: ${relativePath}\n`;
                fullText += `======================================================\n\n`;
                try {
                    const content = fs.readFileSync(fullPath, 'utf-8');
                    fullText += content;
                } catch (e) {
                    fullText += `[Error reading file]`;
                }
            }
        }
    }
}

directoriesToScan.forEach(dir => scanDirectory(path.join(projectRoot, dir)));

// Add root files
const rootFiles = ['client/index.html'];
rootFiles.forEach(file => {
    const fullPath = path.join(projectRoot, file);
    if(fs.existsSync(fullPath)) {
        const content = fs.readFileSync(fullPath, 'utf-8');
        fullText += `\n\n======================================================\n`;
        fullText += `FILE: ${file}\n`;
        fullText += `======================================================\n\n`;
        fullText += content;
    }
});

fs.writeFileSync(outputFile, fullText);
console.log(`Successfully bundled code to ${outputFile}`);
