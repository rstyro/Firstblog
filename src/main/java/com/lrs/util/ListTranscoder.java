package com.lrs.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ListTranscoder<M extends Serializable> extends SerializeTranscoder {

	/**
	 * 解码 反序列化
	 */
	@SuppressWarnings("unchecked")
	public List<M> deserialize(byte[] in) {
		List<M> list = new ArrayList<>();
		ByteArrayInputStream bis = null;
		ObjectInputStream is = null;
		try {
			if (in != null && in.length > 1) {
				bis = new ByteArrayInputStream(in);
				if (bis != null) {
					is = new ObjectInputStream(bis);
					M m = null;
					while ((m = (M) is.readObject()) != null) {
						list.add(m);
					}
					is.close();
					bis.close();
				}
			}
		} catch (IOException e) {
			// e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			close(is);
			close(bis);
		}

		return list;
	}

	/**
	 * 编码 序列化
	 */
	@SuppressWarnings("unchecked")
	@Override
	public byte[] serialize(Object value) {
		if (value == null)
			throw new NullPointerException("Can't serialize null");

		List<M> values = (List<M>) value;

		byte[] results = null;
		ByteArrayOutputStream bos = null;
		ObjectOutputStream os = null;

		try {
			bos = new ByteArrayOutputStream();
			os = new ObjectOutputStream(bos);
			for (M m : values) {
				os.writeObject(m);
			}
			// os.writeObject(null);
			os.close();
			bos.close();
			results = bos.toByteArray();
		} catch (IOException e) {
			throw new IllegalArgumentException("Non-serializable object", e);
		} finally {
			close(os);
			close(bos);
		}

		return results;
	}

}