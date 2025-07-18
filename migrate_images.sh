#!/bin/bash

# 定义源目录和目标目录
POSTS_DIR="content/posts"
STATIC_IMAGES_DIR="static/images"

# 确保目标目录存在
mkdir -p "$STATIC_IMAGES_DIR"

# 遍历 posts 目录下的所有子目录
find "$POSTS_DIR" -type f -name "*.md" | while read -r md_file; do
    # 获取 Markdown 文件的目录路径
    dir_path=$(dirname "$md_file")
    # 获取 Markdown 文件的名称（不带扩展名）
    md_name=$(basename "$md_file" .md)
    
    # 图片目录路径（假设图片目录名为 images）
    images_dir="$dir_path/images"
    
    # 如果存在 images 目录
    if [ -d "$images_dir" ]; then
        # 新目录名称与 Markdown 文件同名
        new_images_dir="$dir_path/$md_name"
        
        # 重命名 images 目录
        mv "$images_dir" "$new_images_dir"
        
        # 遍历新目录下的所有图片文件
        find "$new_images_dir" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | while read -r image_file; do
            # 计算相对于 posts 目录的路径
            relative_path="${image_file#$POSTS_DIR/}"
            
            # 替换目录结构，将文件移动到 static/images 下
            # 保持原有的目录层级
            target_dir="$STATIC_IMAGES_DIR/$(dirname "$relative_path")"
            mkdir -p "$target_dir"
            mv "$image_file" "$target_dir/"
        done
    fi
done

echo "图片迁移完成！"