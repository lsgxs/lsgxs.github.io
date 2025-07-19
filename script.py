import os
import re
from pathlib import Path

def fix_image_paths(md_file_path, static_images_root="static/images"):
    """修复 Markdown 文件中的图片路径"""
    
    # 1. 读取文件内容
    try:
        with open(md_file_path, "r", encoding="utf-8") as f:
            content = f.read()
    except FileNotFoundError:
        print(f"❌ 文件不存在: {md_file_path}")
        return

    # 2. 匹配旧图片路径（根据你的实际格式调整正则表达式）
    # 示例匹配格式：![...]( ![img]/images/dirname/pict-name.png )
    pattern = re.compile(r'!\[.*?\]\(\!\[img\]/images/(.+?)\)')
    
    def replace_match(match):
        relative_path = match.group(1)  # 提取 "dirname/pict-name.png"
        target_path = Path(static_images_root) / relative_path
        
        # 检查文件是否存在（可选）
        if not target_path.exists():
            print(f"⚠️ 文件未找到: {target_path} (原路径: {match.group(0)})")
            return match.group(0)  # 保持原样
        
        # 3. 构建新路径（这里改为网站根目录相对路径）
        new_path = f"/images/{relative_path}"
        return f"![...]( {new_path} )"  # 替换为你的目标格式

    # 4. 替换所有匹配项
    new_content = pattern.sub(replace_match, content)
    
    # 5. 写回文件（建议先备份！）
    with open(md_file_path, "w", encoding="utf-8") as f:
        f.write(new_content)
    print(f"✅ 已处理: {md_file_path}")

# === 使用示例 ===
if __name__ == "__main__":
    # 示例1：处理单个文件
    fix_image_paths("content/posts/example.md")

    # 示例2：批量处理整个目录（取消注释运行）
    # for md_file in Path("content/posts").rglob("*.md"):
    #     fix_image_paths(md_file)