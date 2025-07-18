#!/bin/bash

MAPPING_FILE="image_path_mapping.txt"

# 读取映射文件
while IFS=$'\t' read -r md_file image_base_path; do
    if [[ ! -f "$md_file" ]]; then
        echo "警告: Markdown文件不存在 - $md_file"
        continue
    fi

    echo "正在处理: $md_file -> 图片基础路径: $image_base_path"

    # 创建临时文件
    temp_file=$(mktemp)

    # 处理Markdown文件中的每一行
    while IFS= read -r line; do
        if [[ "$line" =~ !\[.*\]\((.*)\) ]]; then
            original_path="${BASH_REMATCH[1]}"
            
            # 构建新的完整路径
            new_path="$image_base_path/$original_path"

            # 保留alt文本
            if [[ "$line" =~ !\[(.*)\]\((.*)\) ]]; then
                alt_text="${BASH_REMATCH[1]}"
                new_line="![$alt_text]($new_path)"
                echo "$new_line" >> "$temp_file"
            fi
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$md_file"

    # 替换原文件
    mv "$temp_file" "$md_file"

done < "$MAPPING_FILE"

echo "所有Markdown文件的图片路径已根据映射文件修正！"